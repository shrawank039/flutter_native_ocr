import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_ocr/flutter_native_ocr_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterNativeOcr platform = MethodChannelFlutterNativeOcr();
  const MethodChannel channel = MethodChannel('flutter_native_ocr');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getPlatformVersion':
            return 'iOS 16.0';
          case 'recognizeText':
            return 'Sample recognized text';
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), 'iOS 16.0');
  });

  test('recognizeText throws UnsupportedError on non-iOS platforms', () async {
    expect(
      () => platform.recognizeText('/mock/path/image.jpg'),
      throwsA(isA<UnsupportedError>()),
    );
  });
}
