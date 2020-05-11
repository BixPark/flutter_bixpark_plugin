import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export "package:bixpark/bix_park_page.dart";
export 'package:bixpark/src/widget/bix_park_cloud_messaging.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Bixpark {
  static const MethodChannel _channel = const MethodChannel('bixpark');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void init({@required Widget app}) {
    // Set `enableInDevMode` to true to see reports while in debug mode
    // This is only to be used for confirming that reports are being
    // submitted as expected. It is not intended to be used for everyday
    // development.
    Crashlytics.instance.enableInDevMode = true;

    // Pass all uncaught errors to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    runZoned(() {
      runApp(app);
    }, onError: Crashlytics.instance.recordError);
  }
}
