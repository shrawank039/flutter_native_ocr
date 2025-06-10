import 'flutter_native_ocr_platform_interface.dart';

/// A Flutter plugin that provides native OCR (Optical Character Recognition)
/// capabilities using platform-specific frameworks.
///
/// This plugin supports both iOS and Android platforms:
/// - **iOS**: Uses Apple's Vision framework for high-accuracy text recognition
/// - **Android**: Uses Google ML Kit Text Recognition v2 for text recognition
///
/// Both implementations provide on-device processing with no internet connection required.
///
/// Example usage:
/// ```dart
/// final ocr = FlutterNativeOcr();
/// String text = await ocr.recognizeText('/path/to/image.jpg');
/// print('Recognized text: $text');
/// ```
class FlutterNativeOcr {
  /// Returns the platform version string.
  ///
  /// This method is primarily used for debugging and testing purposes.
  /// It returns a platform-specific version string:
  /// - iOS: "iOS [version]" (e.g., "iOS 16.0")
  /// - Android: "Android [version]" (e.g., "Android 13")
  ///
  /// Returns `null` if the platform version cannot be determined.
  Future<String?> getPlatformVersion() {
    return FlutterNativeOcrPlatform.instance.getPlatformVersion();
  }

  /// Recognizes text from an image file using native OCR technology.
  ///
  /// This method performs optical character recognition on the provided image
  /// using platform-specific OCR frameworks:
  /// - **iOS**: Apple's Vision framework for high-accuracy text recognition
  /// - **Android**: Google ML Kit Text Recognition v2 for text recognition
  ///
  /// Both platforms provide on-device processing, ensuring privacy and
  /// eliminating the need for an internet connection.
  ///
  /// [imagePath] The absolute path to the image file to process.
  /// Supported formats include JPEG, PNG, BMP, GIF, WebP, HEIF/HEIC, and TIFF.
  ///
  /// Returns the recognized text as a [String]. If no text is found in the image,
  /// an empty string is returned.
  ///
  /// Throws:
  /// - [UnsupportedError] if called on unsupported platforms (only iOS and Android are supported)
  /// - [PlatformException] if there's an error during text recognition
  /// - [ArgumentError] if the image path is invalid or the file doesn't exist
  ///
  /// Example:
  /// ```dart
  /// final ocr = FlutterNativeOcr();
  /// try {
  ///   String text = await ocr.recognizeText('/path/to/image.jpg');
  ///   if (text.isNotEmpty) {
  ///     print('Found text: $text');
  ///   } else {
  ///     print('No text found in image');
  ///   }
  /// } catch (e) {
  ///   print('OCR failed: $e');
  /// }
  /// ```
  Future<String> recognizeText(String imagePath) {
    return FlutterNativeOcrPlatform.instance.recognizeText(imagePath);
  }
}
