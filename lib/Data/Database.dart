import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Admins {
  final int userID;
  final String password;

  const Admins({
    required this.userID,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'Admins{userID: $userID, password: $password }';
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'admins_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE admins(userID INTEGER PRIMARY KEY, password TEXT)'
      );
    },
    version: 1,
  );

  Future<void> insertAdmins(Admins admins) async {
    final db = await database;
    await db.insert(
      'admins',
      admins.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Admins>> admins() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('admins');

    return List.generate(maps.length, (i) {
      return Admins(
        userID: maps[i]['userID'],
        password: maps[i]['password'],
      );
    });
  }

  var admin_01 = const Admins(
    userID: 0001,
    password: '123456',
  );

  var admin_02 = const Admins(
    userID: 0002,
    password: '123456',
  );

  var admin_03 = const Admins(
    userID: 0003,
    password: '123456',
  );

  var admin_04 = const Admins(
    userID: 0004,
    password: '123456',
  );

  var admin_05 = const Admins(
    userID: 0005,
    password: '123456',
  );

  var admin_06 = const Admins(
    userID: 0006,
    password: '123456',
  );

  await insertAdmins(admin_01);
  await insertAdmins(admin_02);
  await insertAdmins(admin_03);
  await insertAdmins(admin_04);
  await insertAdmins(admin_05);
  await insertAdmins(admin_06);


}