import 'package:flutter/services.dart';

class SystemSettings {
  static void allowOnlyPortraitOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
