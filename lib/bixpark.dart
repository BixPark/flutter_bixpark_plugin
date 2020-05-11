import 'dart:async';

import 'package:flutter/services.dart';

export "package:bixpark/bix_park_page.dart";
export 'package:bixpark/src/widget/bix_park_cloud_messaging.dart';

class Bixpark {
  static const MethodChannel _channel = const MethodChannel('bixpark');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
