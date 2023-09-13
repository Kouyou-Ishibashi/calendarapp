import 'package:intl/intl.dart';

// ダイアログにて、時分を二桁で返す
String returnTimeStr(DateTime day) {
  String hour = day.hour.toString().padLeft(2, '0');
  String minute = day.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

// yyyy-MM-dd HH:mmで返す
String returnDateTimeStr(DateTime date) {
  return DateFormat("yyyy-MM-dd HH:mm").format(date).toString();
}

// yyyy-MM-ddで返す
String returnDateStr(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date).toString();
}
