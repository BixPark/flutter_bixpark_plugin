import 'dart:async';

import 'package:flutter/services.dart';

class Bixpark {
  static const MethodChannel _channel =
      const MethodChannel('bixpark');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
