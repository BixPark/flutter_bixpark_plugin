import 'dart:developer';

import 'package:bixpark/src/widget/bix_park_cloud_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class BixParkPage extends StatefulWidget {
  final Widget child;
  final FCMInterface fcmInterface;
  BixParkPage({Key key, this.child, this.fcmInterface}) : super(key: key);

  @override
  _BixParkPageState createState() => _BixParkPageState();
}

class _BixParkPageState extends State<BixParkPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.subscribeToTopic("bixpark_channel");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        log("onMessage: $message");
        if (this.widget.fcmInterface != null)
          this.widget.fcmInterface.onMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        log("onLaunch: $message");
        if (this.widget.fcmInterface != null)
          this.widget.fcmInterface.onLaunch(message);
      },
      onResume: (Map<String, dynamic> message) async {
        log("onResume: $message");
        if (this.widget.fcmInterface != null)
          this.widget.fcmInterface.onResume(message);
      },
    );
    _firebaseMessaging.getToken().then((String token) {});
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.child;
  }
}
