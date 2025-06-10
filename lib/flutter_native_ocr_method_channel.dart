import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'flutter_native_ocr_platform_interface.dart';

/// An implementation of [FlutterNativeOcrPlatform] that uses method channels.
///
/// This implementation communicates with native platform code via method channels
/// to provide OCR functionality on both iOS and Android platforms.
class MethodChannelFlutterNativeOcr extends FlutterNativeOcrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_ocr');

  /// Returns the platform version string via method channel.
  ///
  /// Invokes the 'getPlatformVersion' method on the native platform.
  ///
  /// Returns a platform-specific version string or `null` if the version
  /// cannot be determined.
  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Recognizes text from an image file using native OCR via method channel.
  ///
  /// This method validates platform support and then invokes the 'recognizeText'
  /// method on the native platform with the provided image path.
  ///
  /// [imagePath] The absolute path to the image file to process.
  ///
  /// Returns the recognized text as a [String], or an empty string if no text
  /// is found.
  ///
  /// Throws:
  /// - [UnsupportedError] if called on platforms other than iOS or Android
  /// - [PlatformException] if there's an error during native method invocation
  @override
  Future<String> recognizeText(String imagePath) async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      throw UnsupportedError(
          'FlutterNativeOcr is only available on iOS and Android.');
    }

    final result = await methodChannel.invokeMethod<String>('recognizeText', {
      'imagePath': imagePath,
    });

    return result ?? '';
  }
}
