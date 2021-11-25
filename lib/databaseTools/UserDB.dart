import 'package:elandguard/model/UserProfileModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDB {
  var database;

  Future<void> initialize() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'eLandGuard-app-user-db.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE Table land("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "picture TEXT, "
          "profileName TEXT, "
          "name TEXT, "
          "password TEXT, "
          "phone TEXT, "
          "email TEXT "
          ")",
        );
      },
      version: 1,
    );
  }

  Future<bool> insertObject(UserProfileModel model) async {
    try {
      final Database db = await database; // Get a reference to the database.
      print('Database(UserProfileModel): $db');
      await db.insert(
        'land',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Insertion Error(UserProfileModel): $e');
      return false;
    }
    return true;
  }

  Future<bool> updateObject(UserProfileModel model) async {
    try {
      final Database db = await database; // Get a reference to the database.
      print('Database(UserProfileModel): $db');
      await db.update(
        'land',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Update Error(UserProfileModel): $e');
      return false;
    }
    return true;
  }

  Future<List<UserProfileModel>> getAllUsers() async {
    try {
      final Database db = await database;
      // Query the obj for all The Objects.
      final List<Map<String, dynamic>> maps = await db.query('land');
      print('List of items from getAllUsers query: $maps');

      return List.generate(
        maps.length,
        (i) {
          return UserProfileModel(
            id: maps[i]['id'],
            picture: maps[i]['picture'],
            profileName: maps[i]['profileName'],
            name: maps[i]['name'],
            password: maps[i]['password'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
          );
        },
      );
    } catch (e) {
      print('Fetch Error(getAllUsers): $e');
      return null;
    }
  }

  Future<UserProfileModel> authenticateUser(
      String email, String password) async {
    try {
      final Database db = await database;

      // Query the obj
      final List<Map<String, dynamic>> maps = await db.rawQuery(
          'select * from land where email=\'$email\' and password=\'$password\'');
      return List.generate(
        maps.length,
        (i) {
          return UserProfileModel(
            id: maps[i]['id'],
            picture: maps[i]['picture'],
            profileName: maps[i]['profileName'],
            name: maps[i]['name'],
            password: maps[i]['password'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
          );
        },
      ).first;
    } catch (e) {
      print('Fetch Error(authenticateUser): $e');
      return null;
    }
  }

  Future<UserProfileModel> getUserByPassword(String password) async {
    try {
      final Database db = await database;

      // Query the obj
      final List<Map<String, dynamic>> maps =
          await db.rawQuery('select * from land where password=\'$password\'');
      return List.generate(
        maps.length,
        (i) {
          return UserProfileModel(
            id: maps[i]['id'],
            picture: maps[i]['picture'],
            profileName: maps[i]['profileName'],
            name: maps[i]['name'],
            password: maps[i]['password'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
          );
        },
      ).first;
    } catch (e) {
      print('Fetch Error(getUserByPassword): $e');
      return null;
    }
  }

  Future<UserProfileModel> getUserByEmail(String email) async {
    try {
      final Database db = await database;

      // Query the obj
      final List<Map<String, dynamic>> maps =
          await db.rawQuery('select * from land where email=\'$email\'');
      return List.generate(
        maps.length,
        (i) {
          return UserProfileModel(
            id: maps[i]['id'],
            picture: maps[i]['picture'],
            profileName: maps[i]['profileName'],
            name: maps[i]['name'],
            password: maps[i]['password'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
          );
        },
      ).first;
    } catch (e) {
      print('Fetch Error(getUserByEmail): $e');
      return null;
    }
  }

  Future<UserProfileModel> getUserByProfile(String profileName) async {
    try {
      final Database db = await database;

      // Query the obj
      final List<Map<String, dynamic>> maps = await db
          .rawQuery('select * from land where profileName=\'$profileName\' ');
      return List.generate(
        maps.length,
        (i) {
          return UserProfileModel(
            id: maps[i]['id'],
            picture: maps[i]['picture'],
            profileName: maps[i]['profileName'],
            name: maps[i]['name'],
            phone: maps[i]['phone'],
            password: maps[i]['password'],
            email: maps[i]['email'],
          );
        },
      ).first;
    } catch (e) {
      print('Fetch Error(getUserByProfile): $e');
      return null;
    }
  }

  Future<bool> updateSetting(UserProfileModel model) async {
    try {
      final db = await database;
      await db.update(
        'land',
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (e) {
      print('Update error(UserProfileModel): $e');
      return false;
    }
    return true;
  }

  Future<void> deleteByProfileName(String profileName) async {
    final db = await database;
    // Remove Object from the database.
    await db.delete(
      'land',
      where: "profileName = ?",
      whereArgs: [profileName],
    );
  }

  Future<void> deleteObject(int id) async {
    final db = await database;
    // Remove Object from the database.
    await db.delete(
      'land',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    // Remove Object from the database.
    await db.delete(
      'land',
    );
  }
}
