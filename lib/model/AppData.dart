import 'package:elandguard/model/UserProfileModel.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  UserProfileModel userData;
  int appNotificationCount = 0;
  int paymentHistory = 0;

  void updateUserData(UserProfileModel model) {
    userData = model;
    notifyListeners();
  }

  void updatePaymentHistory(int size) {
    paymentHistory = size;
    notifyListeners();
  }

  void removeAppNotificationCount() {
    appNotificationCount = 0;
    notifyListeners();
  }
}
