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
    // removeElement(tableName, oldValue);
    // addElement(tableName, newValue);
    // for (var e in parentTable[tableName]!) {
    //   print(e.id);
    // }
    // print(parentTable);
    // print(tableName);
    // print(value.id);

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

    // print(index);
    parentTable[tableName]?.removeAt(index!);
    parentTable[tableName]?.insert(index!, value);
  }
}
