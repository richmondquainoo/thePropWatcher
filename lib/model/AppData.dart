import 'package:elandguard/model/UserProfileModel.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  UserProfileModel userData;
  int appNotificationCount = 0;

  void updateUserData(UserProfileModel model) {
    userData = model;
    notifyListeners();
  }

  void removeAppNotificationCount() {
    appNotificationCount = 0;
    notifyListeners();
  }
}
