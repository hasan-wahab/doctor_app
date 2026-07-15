import 'package:intl/intl.dart';

class DateAndTimeFormater {
  DateAndTimeFormater._();
  static String dateFormat(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return '';

    try {
      DateTime dateTime = DateTime.parse(apiDate);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static int calculateAge(String? dob) {
    if (dob == null || dob.isEmpty) return 0;

    try {
      final birthDate = DateTime.parse(dob);
      final today = DateTime.now();

      int age = today.year - birthDate.year;

      // Agar is saal birthday abhi nahi aaya
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age < 0 ? 0 : age;
    } catch (e) {
      return 0;
    }
  }
}
