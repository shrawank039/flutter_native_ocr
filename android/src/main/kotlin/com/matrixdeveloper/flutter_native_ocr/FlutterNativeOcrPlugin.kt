package com.matrixdeveloper.flutter_native_ocr

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.net.Uri
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import java.io.File
import java.io.IOException

class FlutterNativeOcrPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_native_ocr")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "recognizeText" -> {
        val imagePath = call.argument<String>("imagePath")
        if (imagePath == null) {
          result.error("INVALID_ARGUMENTS", "Missing imagePath", null)
          return
        }
        recognizeText(imagePath, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun recognizeText(imagePath: String, result: Result) {
    try {
      val imageFile = File(imagePath)
      if (!imageFile.exists()) {
        result.error("FILE_NOT_FOUND", "Image file not found: $imagePath", null)
        return
      }

      val image = InputImage.fromFilePath(context, Uri.fromFile(imageFile))
      val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)

      recognizer.process(image)
        .addOnSuccessListener { visionText ->
          val recognizedText = visionText.text
          result.success(recognizedText)
        }
        .addOnFailureListener { e ->
          result.error("TEXT_RECOGNITION_ERROR", "Failed to recognize text: ${e.message}", null)
        }
    } catch (e: IOException) {
      result.error("IO_ERROR", "Error reading image file: ${e.message}", null)
    } catch (e: Exception) {
      result.error("UNKNOWN_ERROR", "Unexpected error: ${e.message}", null)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
