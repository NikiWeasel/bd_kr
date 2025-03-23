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
  final Map<String, List<dynamic>> parentTable;

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
}
