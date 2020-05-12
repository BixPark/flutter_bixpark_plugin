# bixpark_example

Demonstrates how to use the bixpark plugin.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Steps

1. ### Add google services
https://firebase.google.com/docs/android/setup
Add google services build.gradle
```
 repositories {
        //
         maven {
            url 'https://maven.fabric.io/public'
        }
    }
 dependencies {
        // Add the Crashlytics Gradle plugin.// Add fabric classpath
        classpath 'io.fabric.tools:gradle:1.26.1'
        classpath 'com.google.gms:google-services:4.3.3'
 }
```
Add build.gradle
```
// Apply the Crashlytics Gradle plugin
apply plugin: 'io.fabric'
apply plugin: 'com.google.gms.google-services'
```

2. ### Add Google Firebase Messaging

```dart
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
```

## Example Main
```dart
import 'package:bixpark/bixpark.dart';
import 'package:flutter/material.dart';
import 'package:yummy_dish/src/fcm_helper.dart';

void main() {
  Bixpark.init(
      app: MyApp(), addMobAppId: "ca-app-pub-1813863267368130~7504241577");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BixParkPage(
      fcmInterface: FCMHandler(),
      child: MaterialApp(
        title: 'BixPark Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Bix Park Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
```

