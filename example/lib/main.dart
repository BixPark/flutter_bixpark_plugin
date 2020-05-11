import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bixpark/bixpark.dart'; 

void main() {
  Bixpark.init(app: MyApp(), addMobAppId: "ca-app-pub-1813863267368130~7192739639");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class CloudMessageHandler extends FCMInterface {
  @override
  void onLaunch(Map<String, dynamic> message) {
    log("Message On Example $message");
  }

  @override
  void onMessage(Map<String, dynamic> message) {
    log("Message On Example $message");
  }

  @override
  void onResume(Map<String, dynamic> message) {
    log("Message On Example $message");
  }
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Bixpark.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    RemoteConfigBloc remoteConfigBloc = RemoteConfigProvider.of(context);
    remoteConfigBloc.query.add(<String, dynamic>{
      'welcome_message': "Default Message",
    });
    return MaterialApp(
      home: BixParkPage(
        fcmInterface: CloudMessageHandler(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Running on: $_platformVersion\n'),
                FlatButton(
                  color: Colors.amber,
                  onPressed: () {},
                  child: Text(
                    "Analytics",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                FlatButton(
                  color: Colors.lime,
                  onPressed: () {
                    Crashlytics.instance.setString('foo', 'bar');
                    Crashlytics.instance.log("Error Initiate");
                    Crashlytics.instance.crash();
                  },
                  child: Text(
                    "Crashlytics",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                StreamBuilder(
                    stream: remoteConfigBloc.results,
                    builder: (BuildContext context,
                        AsyncSnapshot<RemoteConfig> snapshot) {
                      log("Remote config ${snapshot.data}");
                      if (!snapshot.hasData)
                        return Container(
                          child: Text("${snapshot.data}"),
                        );

                      RemoteConfig rc = snapshot.data;
                      return Container(
                        child: Center(
                          child: Text(rc.getString("welcome_message")),
                        ),
                      );
                    }),
                BixParkAdWidget(addCode: "ca-app-pub-3940256099942544/6300978111",)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
