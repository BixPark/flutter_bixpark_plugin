import 'dart:developer';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class BixParkAdWidget extends StatelessWidget {

   final String addCode;
  const BixParkAdWidget({Key key, this.addCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
        adUnitId: this.addCode,
        adSize: AdmobBannerSize.BANNER ,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          switch (event) {
            case AdmobAdEvent.loaded:
              print('Admob banner loaded!');
              break;

            case AdmobAdEvent.opened:
              print('Admob banner opened!');
              break;

            case AdmobAdEvent.closed:
              print('Admob banner closed!');
              break;

            case AdmobAdEvent.failedToLoad:
              print(
                  'Admob banner failed to load. Error code: ${args['errorCode']}');
              break;
            default:
              log("$event");
          }
        });
  }

}