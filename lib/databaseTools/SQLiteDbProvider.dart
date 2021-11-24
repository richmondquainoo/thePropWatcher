// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
//
// class SQLiteDbProvider {
//
//   String sqldb_query_parcel_coordinate, sqldb_query_spatial_unit_points,sqldb_query_main_transaction;
//      String sqldb_query_setting;
//
//      String sqldb_query_app_user;
//
//   Future<Database> initializeDB() async {
//     //String path = await getDatabasesPath();
//     Directory documentsDirectory = await
//       getApplicationDocumentsDirectory();
//       String path = join(documentsDirectory.path, "appdatabase.db");
//      return await openDatabase(
//          path, version: 1,
//          onOpen: (db) {},
//          onCreate: (Database db, int version) async {
//
//             sqldb_query_setting = "CREATE TABLE IF NOT EXISTS app_settings (s_id INTEGER PRIMARY KEY AUTOINCREMENT, ip_address VARCHAR, ip_port_number VARCHAR, google_direction VARCHAR);";
//             db.execute(sqldb_query_setting);
//
//             sqldb_query_parcel_coordinate = "CREATE TABLE IF NOT EXISTS parcel_coordinate (pc_id INTEGER PRIMARY KEY AUTOINCREMENT, pc_code VARCHAR, x_agg VARCHAR,y_agg VARCHAR,  x_wg VARCHAR, y_wg VARCHAR, parcel_uuid VARCHAR);";
//             db.execute(sqldb_query_parcel_coordinate);
//
//             sqldb_query_main_transaction = "CREATE TABLE IF NOT EXISTS parcel_search_transaction (pst_id INTEGER PRIMARY KEY AUTOINCREMENT, uuid VARCHAR, ticket_number VARCHAR, client_reference_number VARCHAR,coordinate_system VARCHAR,type_of_service VARCHAR,status VARCHAR, result VARCHAR);";
//             db.execute(sqldb_query_main_transaction);
//
//             sqldb_query_spatial_unit_points = "CREATE TABLE IF NOT EXISTS spatial_point (";
//             sqldb_query_spatial_unit_points += "parcel_uid INTEGER PRIMARY KEY AUTOINCREMENT,";
//             sqldb_query_spatial_unit_points += "parcel_id VARCHAR,"; //1
//             sqldb_query_spatial_unit_points += "polygon geometry,";
//             sqldb_query_spatial_unit_points += "number_of_floors VARCHAR,";
//             sqldb_query_spatial_unit_points += "number_of_flats VARCHAR,";
//             sqldb_query_spatial_unit_points += "number_of_owners VARCHAR,";
//             sqldb_query_spatial_unit_points += "type_of_ownership VARCHAR,";
//             sqldb_query_spatial_unit_points += "is_updated VARCHAR);";
//             db.execute(sqldb_query_spatial_unit_points);
//
//
//             sqldb_query_app_user = " CREATE TABLE IF NOT EXISTS app_user (au_id INTEGER PRIMARY KEY AUTOINCREMENT,username VARCHAR, password VARCHAR, full_name VARCHAR, session_active VARCHAR,main_uid VARCHAR,  district VARCHAR,  region VARCHAR, google_direction VARCHAR);";
//             db.execute(sqldb_query_app_user);
//
//
//            /*  await db.execute(
//                "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') values (?, ?, ?, ?, ?)",
//                [1, "iPhone", "iPhone is the stylist phone ever", 1000, "iphone.png"]
//             );  */
//
//          }
//       );
//   }
//
// /*
//       Future<int> insertUser(List<User> users) async {
//         int result = 0;
//         final Database db = await initializeDB();
//         for(var user in users){
//           result = await db.insert('users', user.toMap());
//         }
//         return result;
//       }
//
//
//       Future<List<User>> retrieveUsers() async {
//           final Database db = await initializeDB();
//           final List<Map<String, Object?>> queryResult = await db.query('users');
//           return queryResult.map((e) => User.fromMap(e)).toList();
//         }
//
//  */
//
//     Future<void> deleteUser(int id) async {
//           final db = await initializeDB();
//           await db.delete(
//             'users',
//             where: "id = ?",
//             whereArgs: [id],
//           );
//         }
//
//
// Future getUserData() async{
//
//      final Database db = await initializeDB();
//     var res=await  db.rawQuery("select * from Product");
//     print("result user data $res");
//     print("result user data "+res.toString());
//    // List list =res.toList().map((c) => User.fromMap(c)).toList() ;
//
//     return res.toString();
//
//   }
//
// Future backupDatabase() async{
//
//   /*      Directory documentsDirectory = await getApplicationDocumentsDirectory();
//             String path = join(documentsDirectory.path, "appdatabase.db");
//
//             // Only copy if the database doesn't exist
//             if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
//               // Load database from asset and copy
//               ByteData data = await rootBundle.load(join('assets', 'appdatabase.db'));
//               List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//
//               // Save copied asset to documents
//               await new File(path).writeAsBytes(bytes);
//               } */
//
//
//
//       Directory documentsDirectory = await getApplicationDocumentsDirectory();
//
//             String newPath = join(documentsDirectory.path, 'appdatabase.db');
//             final exists = await databaseExists(newPath);
//             print(exists);
//             print(newPath);
//             if (exists) {
//                 print("result 334433 ");
//                 try {
//                    print("result 55555555 ");
//                     //final dbPath = await ExtStorage.getExternalStorageDirectory();
//
//                    // print(dbPath);
//                     //final path = join(dbPath, 'backup.db');
//                   //  File(newPath).copySync(path);
//
//
// List<Directory> extDirectories = await getExternalStorageDirectories();
//  print(extDirectories);
// List<String> dirs = extDirectories[0].toString().split('/');
// print(dirs);
// String rebuiltPath = '/' + dirs[1] + '/' + dirs[2] + '/' + dirs[3];
//
// print("rebuilt path: " + rebuiltPath);
//
//    print(rebuiltPath);
//  String pathDes = join(rebuiltPath, "appdatabase.db");
//   print(pathDes);
//
//   File(newPath).copySync(pathDes);
//  ByteData data = await rootBundle.load(newPath);
//   print(data);
//   print("result 1");
//               List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   print("result 2");
//               // Save copied asset to documents
//               await new File(pathDes).writeAsBytes(bytes);
//
//
//                  //  final path = join(rebuiltPath, 'backup.db');
//                 //    print(path);
//                 //  File(newPath).copySync(path);
//
//                      print("result bauhddufi ");
//                 } catch (_) {}
//             }
//
//
//  print("result user data correct ");
//
//       return '';
//
//
//   }
//
//
//
//             /* Future<void> initDB() async {
//             Directory documentsDirectory = await getApplicationDocumentsDirectory();
//             String newPath = join(documentsDirectory.path, '/backup.db');
//             final exist = await databaseExists(newPath);
//             if (!exists) {
//                 try {
//                     final dbPath = await ExtStorage.getExternalStoragePublicDirectory(
//                     ExtStorage.DIRECTORY_DOCUMENTS);
//                     final path = join(dbPath, '/backup.db');
//                     File(path).copySync(newPath);
//                 } catch (_) {}
//             }
//         } */
//
// }