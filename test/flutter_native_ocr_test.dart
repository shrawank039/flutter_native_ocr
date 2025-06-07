import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_ocr/flutter_native_ocr.dart';
import 'package:flutter_native_ocr/flutter_native_ocr_platform_interface.dart';
import 'package:flutter_native_ocr/flutter_native_ocr_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeOcrPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeOcrPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> recognizeText(String imagePath) =>
      Future.value('Mock OCR text');
}

void main() {
  final FlutterNativeOcrPlatform initialPlatform =
      FlutterNativeOcrPlatform.instance;

  test('$MethodChannelFlutterNativeOcr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeOcr>());
  });

  test('getPlatformVersion', () async {
    FlutterNativeOcr flutterNativeOcrPlugin = FlutterNativeOcr();
    MockFlutterNativeOcrPlatform fakePlatform = MockFlutterNativeOcrPlatform();
    FlutterNativeOcrPlatform.instance = fakePlatform;

    expect(await flutterNativeOcrPlugin.getPlatformVersion(), '42');
  });

  test('recognizeText', () async {
    FlutterNativeOcr flutterNativeOcrPlugin = FlutterNativeOcr();
    MockFlutterNativeOcrPlatform fakePlatform = MockFlutterNativeOcrPlatform();
    FlutterNativeOcrPlatform.instance = fakePlatform;

    expect(await flutterNativeOcrPlugin.recognizeText('/mock/path/image.jpg'),
        'Mock OCR text');
  });
}
