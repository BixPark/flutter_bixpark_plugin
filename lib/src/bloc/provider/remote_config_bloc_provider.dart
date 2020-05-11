import 'package:bixpark/src/bloc/remote_config_bloc.dart';
import 'package:flutter/material.dart';

class RemoteConfigProvider extends InheritedWidget {
  final RemoteConfigBloc remoteConfigBloc;

  RemoteConfigProvider(
      {Key key, RemoteConfigBloc remoteConfigBloc, Widget child})
      : this.remoteConfigBloc = remoteConfigBloc ?? RemoteConfigBloc(),
        super(child: child, key: key);
  static RemoteConfigBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<RemoteConfigProvider>())
          .remoteConfigBloc;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
