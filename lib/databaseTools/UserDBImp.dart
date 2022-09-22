import 'package:elandguard/model/UserProfileModel.dart';
import 'package:flutter/material.dart';

import 'UserDB.dart';

class UserDBImplementation {
  final BuildContext context;
  UserDBImplementation({this.context});

  UserDB userDB = UserDB();

  Future<void> initializeDB() async {
    try {
      await userDB.initialize();
    } catch (e) {
      print('initializeDB error: $e');
    }
  }

  Future<bool> saveUser(UserProfileModel model) async {
    try {
      await initializeDB();
      await userDB.deleteAll();
      return userDB.insertObject(model);
    } catch (e) {
      print('saveUser error: $e');
      return false;
    }
  }

  Future<bool> updateUser(UserProfileModel model) async {
    try {
      await initializeDB();
      return userDB.updateObject(model);
    } catch (e) {
      print('saveUser error: $e');
      return false;
    }
  }

  Future<UserProfileModel> getByProfileName(String profileName) async {
    try {
      await initializeDB();
      return userDB.getUserByProfile(profileName);
    } catch (e) {
      print('getByProfileName error: $e');
      return null;
    }
  }

  Future<UserProfileModel> getByEmail(String email) async {
    try {
      await initializeDB();
      return userDB.getUserByEmail(email);
    } catch (e) {
      print('getByEmail error: $e');
      return null;
    }
  }

  Future<UserProfileModel> getByPassword(String password) async {
    try {
      await initializeDB();
      return userDB.getUserByPassword(password);
    } catch (e) {
      print('getByPassword error: $e');
      return null;
    }
  }

  Future<UserProfileModel> authenticateAgainstLocalDB(
      String email, String password) async {
    try {
      await initializeDB();
      return userDB.authenticateUser(email, password);
    } catch (e) {
      print('authenticateAgainstLocalDB error: $e');
      return null;
    }
  }

  Future<UserProfileModel> getUser() async {
    try {
      await initializeDB();
      List<UserProfileModel> users = await userDB.getAllUsers();
      if (users.isNotEmpty) {
        return users.first;
      }
    } catch (e) {
      print('getUser error: $e');
      return null;
    }
    return null;
  }

  Future<UserProfileModel> getLoggedInUser() async {
    try {
      await initializeDB();
      List<UserProfileModel> users = await userDB.getAllUsers();
      if (users.isNotEmpty) {
        if (users.first.loggedIn == '1') {
          return users.first;
        }
      }
    } catch (e) {
      print('getUser error: $e');
      return null;
    }
    return null;
  }

  Future<void> deleteAll() async {
    try {
      await initializeDB();
      return userDB.deleteAll();
    } catch (e) {
      print('authenticateAgainstLocalDB error: $e');
      return null;
    }
  }
}
