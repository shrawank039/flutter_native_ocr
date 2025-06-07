import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_native_ocr/flutter_native_ocr.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    final FlutterNativeOcr plugin = FlutterNativeOcr();
    final String? version = await plugin.getPlatformVersion();
    expect(version?.isNotEmpty, true);
  });
}
