import 'package:bixpark/bixpark.dart';
import 'package:rxdart/rxdart.dart';

class RemoteConfigBloc {
  Stream<RemoteConfig> _result = Stream.empty();
  Stream<RemoteConfig> get results => _result;

  ReplaySubject<Map<String, dynamic>> _query =
      ReplaySubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get query => _query;

  RemoteConfigBloc() {
    _result = _query.distinct().asyncMap((event) async {
      return setupRemoteConfig(event);
    }).asBroadcastStream();
  }

  Future<RemoteConfig> setupRemoteConfig(Map<String, dynamic> defaults) async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    return remoteConfig;
  }

  void dispose() {
    _query.close();
  }
}
