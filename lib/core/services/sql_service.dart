import 'dart:ffi' as ffi;

import 'package:bd_kr/core/models/user.dart';
import 'package:bd_kr/core/table_models/owner_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:bd_kr/core/models/all_tables.dart';
import 'package:bd_kr/core/table_models/car.dart';
import 'package:bd_kr/core/table_models/car_body_type.dart';
import 'package:bd_kr/core/table_models/car_brand.dart';
import 'package:bd_kr/core/table_models/car_color.dart';
import 'package:bd_kr/core/table_models/city.dart';
import 'package:bd_kr/core/table_models/district.dart';
import 'package:bd_kr/core/table_models/inspection.dart';
import 'package:bd_kr/core/table_models/owner.dart';
import 'package:bd_kr/core/table_models/phone.dart';
import 'package:bd_kr/core/table_models/street.dart';
import 'package:bd_kr/core/table_models/note.dart';

import 'package:bd_kr/core/models/search_query.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;

// ffi.DynamicLibrary _openSqliteUnderWindows() {
//   return ffi.DynamicLibrary.open('sqlite3.dll');
// }

class SqlService {
  Future<Database> _getDatabase() async {
    DatabaseFactory databaseFactoryUsed;

    if ((defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux) &&
        !kIsWeb) {
      // Для Windows и Linux используем FFI
      sqfliteFfiInit();
      databaseFactoryUsed = databaseFactoryFfi;
    } else {
      // Для Android, iOS, macOS используем стандартный SQLite
      databaseFactoryUsed = sql.databaseFactory;
    }

    final dbPath = await databaseFactoryUsed.getDatabasesPath();
    final myPath = path.join(dbPath, 'gbdd.db');

    final exists = await databaseFactoryUsed.databaseExists(myPath);

    final db = await databaseFactoryUsed.openDatabase(myPath,
        options: OpenDatabaseOptions(version: 1));

    if (!exists) {
      await _createDb(db);
    }

    // print(myPath);
    await db.execute('PRAGMA foreign_keys = ON;');

    // final result = await db.rawQuery('PRAGMA foreign_keys;');
    // print(result); // Должно вернуть [{foreign_keys: 1}], если включено.
    return db;
  }

  Future<void> _createDb(Database db) async {
    await db.execute('''
  CREATE TABLE users (
  id TEXT PRIMARY KEY, 
  login TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  password TEXT NOT NULL,
  is_admin INTEGER
);
''');

    await db.execute('''
CREATE TABLE car_brands (
  id INTEGER PRIMARY KEY, 
  name TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE districts (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE streets (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE car_colors (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE cities (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE car_body_types (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE owners (
  id INTEGER PRIMARY KEY,
  owner_type TEXT,
  inn TEXT,
  FOREIGN KEY (inn) REFERENCES owner_info (inn) ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE owner_info (
  inn TEXT PRIMARY KEY,
  owner_name TEXT,
  city_id INTEGER,
  district_id INTEGER,
  street_id INTEGER,
  house TEXT,
  apartment TEXT,
  organization_head TEXT,
  FOREIGN KEY (city_id) REFERENCES cities (id) ON DELETE CASCADE,
  FOREIGN KEY (district_id) REFERENCES districts (id) ON DELETE CASCADE,
  FOREIGN KEY (street_id) REFERENCES streets (id) ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE phones (
  id INTEGER PRIMARY KEY,
  owner_id INTEGER,
  phone_number TEXT,
  FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE cars (
  id INTEGER PRIMARY KEY,
  engine_volume REAL,
  color_id INTEGER,
  engine_power REAL,
  all_wheel_drive INTEGER,
  license_plate TEXT,
  model TEXT,
  steering_wheel TEXT CHECK(steering_wheel IN ('Left', 'Right')),
  annual_tax REAL,
  year INTEGER,
  engine_number TEXT,
  stolen INTEGER,
  return_date TEXT,
  theft_date TEXT,
  body_type_id INTEGER,
  brand_id INTEGER,
  owner_id INTEGER,
  FOREIGN KEY (color_id) REFERENCES car_colors (id) ON DELETE CASCADE,
  FOREIGN KEY (body_type_id) REFERENCES car_body_types (id) ON DELETE CASCADE,
  FOREIGN KEY (brand_id) REFERENCES car_brands (id) ON DELETE CASCADE,
  FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE inspections (
  id INTEGER PRIMARY KEY,
  inspector_name TEXT,
  inspection_date TEXT,
  failure_reasons TEXT,
  passed INTEGER,
  mileage INTEGER,
  inspection_fee REAL,
  sign_fee REAL,
  car_id INTEGER,
  FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE notes (
  id INTEGER PRIMARY KEY,
  car_id INTEGER,
  content TEXT,
  FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE
);
''');
  }

  Future<List<dynamic>> loadTableByName(String tableName,
      {String? where}) async {
    final db = await _getDatabase();

    String query = 'SELECT * FROM $tableName';
    if (where != null) {
      query += ' WHERE $where';
    }

    // print(query);

    final result = await db.rawQuery(query);

    switch (tableName) {
      case 'car_brands':
        return result
            .map((row) => CarBrand(
                  id: row['id'] as int,
                  name: row['name'] as String,
                ))
            .toList();
      case 'districts':
        return result
            .map((row) => District(
                  id: row['id'] as int,
                  name: row['name'] as String,
                ))
            .toList();
      case 'streets':
        return result
            .map((row) => Street(
                  id: row['id'] as int,
                  name: row['name'] as String,
                ))
            .toList();
      case 'car_colors':
        return result
            .map((row) => CarColor(
                  id: row['id'] as int,
                  name: row['name'] as String,
                ))
            .toList();
      case 'cities':
        return result
            .map((row) => City(
                  id: row['id'] as int,
                  name: row['name'] as String,
                ))
            .toList();
      case 'car_body_types':
        return result
            .map((row) => CarBodyType(
                  id: row['id'] as int,
                  name: row['name'] as String,
                ))
            .toList();
      case 'owners':
        return result
            .map((row) => Owner(
                  id: row['id'] as int,
                  ownerType: row['type'] as String?,
                  inn: row['inn'] as String?,
                ))
            .toList();
      case 'owner_info':
        return result
            .map((row) => OwnerInfo(
                  ownerName: row['owner_name'] as String,
                  inn: row['inn'] as String,
                  cityId: row['city_id'] as int?,
                  districtId: row['district_id'] as int?,
                  streetId: row['street_id'] as int?,
                  house: row['house'] as String?,
                  apartment: row['apartment'] as String?,
                  organizationHead: row['organization_head'] as String?,
                ))
            .toList();
      case 'phones':
        return result
            .map((row) => Phone(
                  id: row['id'] as int,
                  ownerId: row['owner_id'] as int?,
                  phoneNumber: row['phone_number'] as String?,
                ))
            .toList();
      case 'cars':
        return result
            .map((row) => Car(
                  id: row['id'] as int,
                  engineVolume: row['engine_volume'] as double?,
                  colorId: row['color_id'] as int?,
                  enginePower: row['engine_power'] as double?,
                  allWheelDrive:
                      row['all_wheel_drive'] as int == 1 ? true : false,
                  licensePlate: row['license_plate'] as String?,
                  model: row['model'] as String?,
                  steeringWheel: row['steering_wheel'] as String?,
                  annualTax: row['annual_tax'] as double?,
                  year: row['year'] as int?,
                  engineNumber: row['engine_number'] as String?,
                  stolen: row['stolen'] as int == 1 ? true : false,
                  returnDate: DateTime.tryParse(row['return_date'] as String),
                  theftDate: DateTime.tryParse(row['theft_date'] as String),
                  bodyTypeId: row['body_type_id'] as int?,
                  brandId: row['brand_id'] as int?,
                  ownerId: row['owner_id'] as int?,
                ))
            .toList();
      case 'inspections':
        return result
            .map((row) => Inspection(
                  id: row['id'] as int,
                  inspectorName: row['inspector_name'] as String?,
                  inspectionDate:
                      DateTime.tryParse(row['inspection_date'] as String),
                  failureReasons: row['failure_reasons'] as String?,
                  passed: row['passed'] as int == 1 ? true : false,
                  mileage: row['mileage'] as int?,
                  inspectionFee: row['inspection_fee'] as double?,
                  signFee: row['sign_fee'] as double?,
                  carId: row['car_id'] as int?,
                ))
            .toList();
      case 'notes':
        return result
            .map((row) => Note(
                  id: row['id'] as int,
                  carId: row['car_id'] as int?,
                  content: row['content'] as String?,
                ))
            .toList();
      default:
        throw Exception('Таблица с именем $tableName не найдена');
    }
  }

  Future<AllTables> loadTables() async {
    final carBrands = await loadTableByName('car_brands');
    final districts = await loadTableByName('districts');
    final streets = await loadTableByName('streets');
    final carColors = await loadTableByName('car_colors');
    final cities = await loadTableByName('cities');
    final carBodyTypes = await loadTableByName('car_body_types');
    final owners = await loadTableByName('owners');
    final ownerInfos = await loadTableByName('owner_info');
    final phones = await loadTableByName('phones');
    final cars = await loadTableByName('cars');
    final inspections = await loadTableByName('inspections');
    final notes = await loadTableByName('notes');

    return AllTables(parentTable: {
      'car_brands': carBrands,
      'districts': districts,
      'streets': streets,
      'car_colors': carColors,
      'cities': cities,
      'car_body_types': carBodyTypes,
      'owners': owners,
      'owner_info': ownerInfos,
      'phones': phones,
      'cars': cars,
      'inspections': inspections,
      'notes': notes,
    });
  }

  Future<List<User>> loadUsers() async {
    final db = await _getDatabase();
    final dataUsers = await db.query('users');
    final users = dataUsers
        .map((row) => User(
              id: row['id'] as String,
              login: row['login'] as String,
              isAdmin: row['is_admin'] as int == 1 ? true : false,
              password: row['password'] as String,
              phoneNumber: row['phone_number'] as String,
            ))
        .toList();

    return users;
  }

  User? doesUserExist(List<User> allUsers, User inputUser) {
    for (var e in allUsers) {
      if (e.login == inputUser.login && e.password == inputUser.password) {
        return User(
            login: e.login,
            phoneNumber: e.phoneNumber,
            isAdmin: e.isAdmin,
            password: e.password);
      }
    }
    return null;
  }

  Future<void> addTableRow(dynamic newTableRow) async {
    final db = await _getDatabase();

    await db.insert(
      newTableRow.getTableName(),
      replaceBools(newTableRow.toMap()),
    );
  }

  void editTableRow(dynamic tableRow) async {
    final db = await _getDatabase();

    var tableRowMap = (tableRow.toMap() as Map<String, dynamic>);

    await db.transaction((txn) async {
      await txn.update(tableRow.getTableName(), replaceBools(tableRowMap),
          where: tableRow is OwnerInfo
              ? 'inn = \'${tableRow.inn}\''
              : 'id = \'${tableRow.id}\'');
    });
    // db.update(tableRow.getTableName(), replaceBools(tableRowMap),
    //     where: tableRow is OwnerInfo
    //         ? 'inn = \'${tableRow.inn}\''
    //         : 'id = \'${tableRow.id}\'');
  }

  void deleteTableRow(dynamic tableRowToDelete) async {
    final db = await _getDatabase();

    await db.transaction((txn) async {
      await txn.delete(tableRowToDelete.getTableName(),
          where: tableRowToDelete is OwnerInfo
              ? 'inn = \'${tableRowToDelete.inn}\''
              : 'id = \'${tableRowToDelete.id}\'');
    });
    // await db.delete(tableRowToDelete.getTableName(),
    //     where: 'id = \'${tableRowToDelete.id}\'');

    // state = state.where((m) => m.id != noteToDelete.id).toList();
  }

  Future<List<dynamic>> searchInTable(
      {required AllTables allTables,
      required dynamic tableRow,
      required List<SearchQuery> sqList}) async {
    // AllTables allTables = await loadTables();

    // var loadedTable
    final result = await loadTableByName(tableRow.getTableName(),
        where: getEndOfQuery(sqList));

    // print(loadTableByName(tableRow.getTableName()));
    // print(tableRow.getTableName());
    //
    // print(allTables.parentTable);
    // print(allTables.parentTable[tableRow.getTableName()]);

    // allTables.parentTable[tableRow.getTableName()] = result;

    return result;
  }

  String getEndOfQuery(List<SearchQuery> sqList) {
    String result = '';

    for (int i = 0; i < sqList.length; i++) {
      switch (sqList[i].searchType) {
        case '=':
          result =
              '$result ${sqList[i].searchColumn} = ${sqList[i].searchString}';
        case '>=':
          result =
              '$result ${sqList[i].searchColumn} >= ${sqList[i].searchString}';

        case '<=':
          result =
              '$result ${sqList[i].searchColumn} <= ${sqList[i].searchString}';

        case '>':
          result =
              '$result ${sqList[i].searchColumn} > ${sqList[i].searchString}';

        case '<':
          result =
              '$result ${sqList[i].searchColumn} < ${sqList[i].searchString}';

        case 'Входит':
          result =
              '$result ${sqList[i].searchColumn} LIKE \'${sqList[i].searchString}%\'';

        case 'Начинается с':
          result =
              '$result ${sqList[i].searchColumn} LIKE \'%${sqList[i].searchString}%\'';
      }
      if (i != sqList.length - 1) {
        result = '$result AND';
      }
    }
    // print(result);
    return result;
  }

  Map<String, dynamic> replaceBools(Map<String, dynamic> tableRowMap) {
    var updatedMap = tableRowMap.map((key, value) {
      if (value is bool) {
        return MapEntry(key, value ? 1 : 0);
      }
      return MapEntry(key, value);
    });
    return updatedMap;
  }
}
