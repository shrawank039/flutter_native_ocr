import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_ocr_method_channel.dart';

abstract class FlutterNativeOcrPlatform extends PlatformInterface {
  FlutterNativeOcrPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeOcrPlatform _instance = MethodChannelFlutterNativeOcr();

  static FlutterNativeOcrPlatform get instance => _instance;

  static set instance(FlutterNativeOcrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> recognizeText(String imagePath) {
    throw UnimplementedError('recognizeText() has not been implemented.');
  }
}
