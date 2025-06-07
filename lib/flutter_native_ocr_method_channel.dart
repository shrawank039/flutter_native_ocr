import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'flutter_native_ocr_platform_interface.dart';

class MethodChannelFlutterNativeOcr extends FlutterNativeOcrPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_ocr');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> recognizeText(String imagePath) async {
    if (!Platform.isIOS) {
      throw UnsupportedError('FlutterNativeOcr is only available on iOS.');
    }

    final result = await methodChannel.invokeMethod<String>('recognizeText', {
      'imagePath': imagePath,
    });

    return result ?? '';
  }
}
