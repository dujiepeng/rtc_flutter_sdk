import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_flutter_sdk/rtc_flutter_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('rtc_flutter_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RtcFlutterSdk.platformVersion, '42');
  });
}
