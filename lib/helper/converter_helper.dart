import 'package:intl/intl.dart';

class ConverterHelper {
  static dateFromJson(String value) {
    DateTime? dateTime = DateTime.now();
    if (value != null || value.isNotEmpty) {
      dateTime = DateTime.parse(value);
    }
    return dateTime;
  }

  static dateFormat({value}) {
    String formattedDate = DateFormat.yMd().format(value);
    return '$formattedDate (Age ${calculateAge(value)})';
  }

  static digitFormat(int value) {
    return value.toString().length == 1 ? '0$value' : value.toString();
  }

  static calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
