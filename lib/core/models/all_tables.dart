import 'package:bd_kr/core/table_models/car.dart';
import 'package:bd_kr/core/table_models/car_body_type.dart';
import 'package:bd_kr/core/table_models/car_brand.dart';
import 'package:bd_kr/core/table_models/car_color.dart';
import 'package:bd_kr/core/table_models/city.dart';
import 'package:bd_kr/core/table_models/district.dart';
import 'package:bd_kr/core/table_models/inspection.dart';
import 'package:bd_kr/core/table_models/note.dart';
import 'package:bd_kr/core/table_models/owner.dart';
import 'package:bd_kr/core/table_models/owner_info.dart';
import 'package:bd_kr/core/table_models/phone.dart';
import 'package:bd_kr/core/table_models/street.dart';

class AllTables {
  Map<String, List<dynamic>> parentTable;

  AllTables({required this.parentTable});

  AllTables.emptyTables() : parentTable = {};

  List<String> getTableNames() => [
        'car_brands',
        'districts',
        'streets',
        'car_colors',
        'cities',
        'car_body_types',
        'owners',
        'owner_info',
        'phones',
        'cars',
        'inspections',
        'notes',
      ];

  void addElement(String tableName, dynamic value) {
    parentTable[tableName]?.add(value);
  }

  void removeElement(String tableName, dynamic value) {
    parentTable[tableName]?.remove(value);
  }

  void updateElement(String tableName, dynamic value, dynamic id) {
    int? index;
    if (value is OwnerInfo) {
      index = parentTable[tableName]?.indexWhere(
        (element) => element.inn == id,
      );
    } else {
      index = parentTable[tableName]?.indexWhere(
        (element) => element.id == id,
      );
    }
    parentTable[tableName]?.removeAt(index!);
    parentTable[tableName]?.insert(index!, value);
  }

  void insertFilteredTable(String tableName, List<dynamic> value) {
    // parentTable = Map.from(parentTable)..[tableName] = value;

    // print('parentTable[tableName]');
    // print(parentTable[tableName]);
    // parentTable[tableName] = value;
    // print(value);

    List difference = [];

    if (value[0] is OwnerInfo) {
      var valueIds = value.map((e) => e.inn).toSet();

      for (var item in parentTable[tableName]!) {
        if (!valueIds.contains(item.inn)) {
          difference.add(item);
        }
      }

      for (var e in difference) {
        parentTable[tableName]?.removeWhere(
          (element) => element.inn == e.inn,
        );
      }
    } else {
      var valueIds = value.map((e) => e.id).toSet();

      for (var item in parentTable[tableName]!) {
        if (!valueIds.contains(item.id)) {
          difference.add(item);
        }
      }

      for (var e in difference) {
        parentTable[tableName]?.removeWhere(
          (element) => element.id == e.id,
        );
      }
    }

    // print(parentTable[tableName]);
  }
}
