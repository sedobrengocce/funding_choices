import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:funding_choices/funding_choices.dart';

void main() {
  const MethodChannel channel = MethodChannel('funding_choices');

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
  });
}
