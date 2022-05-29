import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:diplom_work/Screens/CreateUser.dart';

class Admins {
  final String? id;
  final String? avatarUrl;
  final String? name;
  final String? jobTitle;
  final String? email;
  final String? phone;
  final String? addressR;
  final String? addressP;
  final String? idSeries;
  final String? idNum;
  final String? idcreateData;
  final String? idwhoGive;
  final String? tariff;
  final String? money;

  const Admins({
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.addressR,
    required this.addressP,
    required this.idSeries,
    required this.idNum,
    required this.idcreateData,
    required this.idwhoGive,
    required this.tariff,
    required this.money,
  });

  void pickFiless() async{
    var result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result == null) return;
    var file = result!.files.first;

    viewFile(file);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatarUrl': avatarUrl,
      'name': name,
      'jobTitle': jobTitle,
      'email': email,
      'phone': phone,
      'addressR': addressR,
      'addressP': addressP,
      'idSeries': idSeries,
      'idNum': idNum,
      'idcreateData': idcreateData,
      'idwhoGive': idwhoGive,
      'tariff': tariff,
      'money': money,
    };
  }

  @override
  String toString() {
    return 'Admins{'
        'id: $id,'
        ' avatarUrl: $avatarUrl '
        ' name: $name '
        ' jobTitle: $jobTitle '
        ' email: $email '
        ' phone: $phone '
        ' addressR: $addressR '
        ' addressP: $addressP '
        ' idSeries: $idSeries '
        ' idNum: $idNum '
        ' idcreateData: $idcreateData '
        ' idwhoGive: $idwhoGive '
        ' tariff: $tariff '
        ' money: $money '
        '}';
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}


void dataMain() async {
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
        id: maps[i]['id'],
        avatarUrl: maps[i]['avatarUrl'],
        name: maps[i]['name'],
        jobTitle: maps[i]['jobTitle'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        addressR: maps[i]['addressR'],
        addressP: maps[i]['addressP'],
        idSeries: maps[i]['idSeries'],
        idNum: maps[i]['idNum'],
        idcreateData: maps[i]['idcreateData'],
        idwhoGive: maps[i]['idwhoGive'],
        tariff: maps[i]['tariff'],
        money: maps[i]['money'],
      );
    });
  }

  var admin_01 = const Admins(
    id: inputDataUser,
    avatarUrl: inputDataUser,
    name: inputDataUser,
    jobTitle: inputDataUser,
    email: inputDataUser,
    phone: inputDataUser,
    addressR: inputDataUser,
    addressP: inputDataUser,
    idSeries: inputDataUser,
    idNum: inputDataUser,
    idcreateData: inputDataUser,
    idwhoGive: inputDataUser,
    tariff: inputDataUser,
    money: inputDataUser,

  );

  await insertAdmins(admin_01);

}

