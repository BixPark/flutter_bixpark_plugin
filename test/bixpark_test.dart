import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bixpark/bixpark.dart';

void main() {
  const MethodChannel channel = MethodChannel('bixpark');

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
    expect(await Bixpark.platformVersion, '42');
  });
}
