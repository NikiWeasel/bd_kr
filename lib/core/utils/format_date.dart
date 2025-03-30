import 'package:intl/intl.dart';

String formatDate(DateTime? dateTime) {
  // print(dateTime);
  if (dateTime == null) return 'Not selected';
  var format = DateFormat('dd.MM.yyyy');
  return format.format(dateTime);
}
