import 'flutter_native_ocr_platform_interface.dart';

class FlutterNativeOcr {
  Future<String?> getPlatformVersion() {
    return FlutterNativeOcrPlatform.instance.getPlatformVersion();
  }

  /// Recognizes text from an image file using native OCR
  ///
  /// On iOS: Uses Apple's Vision framework
  /// On Android: Uses Google ML Kit Text Recognition v2
  ///
  /// [imagePath] The absolute path to the image file
  /// Returns the recognized text as a String, or empty string if no text is found
  Future<String> recognizeText(String imagePath) {
    return FlutterNativeOcrPlatform.instance.recognizeText(imagePath);
  }
}
