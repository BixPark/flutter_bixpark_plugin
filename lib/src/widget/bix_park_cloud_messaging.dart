
abstract class FCMInterface {
  void onMessage(Map<String, dynamic> message);
  void onLaunch(Map<String, dynamic> message);
  void onResume(Map<String, dynamic> message);
}
