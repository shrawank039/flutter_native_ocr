import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_ocr_method_channel.dart';

/// The interface that implementations of flutter_native_ocr must implement.
///
/// Platform implementations should extend this class rather than implement it as
/// `FlutterNativeOcrPlatform` does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass will
/// get the default implementation, while platform implementations that `implements`
/// this interface will be broken by newly added [FlutterNativeOcrPlatform] methods.
abstract class FlutterNativeOcrPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeOcrPlatform.
  FlutterNativeOcrPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeOcrPlatform _instance = MethodChannelFlutterNativeOcr();

  /// The default instance of [FlutterNativeOcrPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeOcr].
  static FlutterNativeOcrPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeOcrPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeOcrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns the platform version string.
  ///
  /// Platform implementations should override this method to return the
  /// appropriate platform version string.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Recognizes text from an image file using platform-specific OCR.
  ///
  /// Platform implementations should override this method to provide
  /// OCR functionality using the appropriate native framework:
  /// - iOS: Apple's Vision framework
  /// - Android: Google ML Kit Text Recognition
  ///
  /// [imagePath] The absolute path to the image file to process.
  ///
  /// Returns the recognized text as a string, or empty string if no text is found.
  Future<String> recognizeText(String imagePath) {
    throw UnimplementedError('recognizeText() has not been implemented.');
  }
}
