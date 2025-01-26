// import 'dart:io';

// import 'package:key_keeper/src/app/models/models.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._();
//   DatabaseHelper._();

//   static Database? _db;
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await openDatabse();
//     return _db!;
//   }

//   static const String _passwordDB = 'keeper_db.db';
//   static const String _passwordTable = 'passwords';

//   Future<Database> openDatabse() async {
//     const query = '''
//           CREATE TABLE $_passwordTable (
//             ${PasswordFields.id} TEXT PRIMARY KEY,
//             ${PasswordFields.password} TEXT NOT NULL,
//             ${PasswordFields.username} TEXT NOT NULL,
//             ${PasswordFields.dateTimeCreated} INTEGER NOT NULL,
//             ${PasswordFields.lastTimeUpdated} INTEGER NOT NULL,
//             ${PasswordFields.mode} TEXT NOT NULL,
//             ${PasswordFields.icon} TEXT NOT NULL,
//             ${PasswordFields.userID} TEXT NOT NULL
//           )
//         ''';

//     if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
//       sqfliteFfiInit();
//       var databaseFactory = databaseFactoryFfi;
//       var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
//       await db.execute(query);
//       return db;
//     } else {
//       final dirPath = getDatabasesPath();
//       final dbPath = '$dirPath/$_passwordDB';
//       final db = openDatabase(
//         dbPath,
//         version: 1,
//         onCreate: (db, _) {
//           db.execute(query);
//         },
//       );
//       return db;
//     }
//   }

//   Future<List<Password>> getAllPasswords() async {
//     final db = await database;
//     final dbList = await db.query(_passwordTable);
//     final list =
//         dbList.map((p) => Password.fromMap(p as Map<String, dynamic>)).toList();
//     return list;
//   }

//   Future<Password> addNewPassword({
//     required Password password,
//     required String userID,
//   }) async {
//     final db = await database;
//     await db.insert(
//       _passwordTable,
//       password.toMap(userID: userID),
//     );
//     return password;
//   }
// }
