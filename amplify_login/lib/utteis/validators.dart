import 'package:intl/intl.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool isDate(String input, String format) {
  try {
    final DateTime d = DateFormat(format).parseStrict(input);
    //print(d);
    return true;
  } catch (e) {
    //print(e);
    return false;
  }
}

DateTime strToDate(String input, String format) {
  final DateTime d = DateFormat(format).parseStrict(input);
  //print(d);
  return d;
}

String dateToStr(DateTime input, String format) {
  final String d = DateFormat(format).format(input);
  //print(d);
  return d;
}
