import 'package:intl/intl.dart';

class AppDateFormat {
  static DateTime convertBrazilianDateString(String brazilianDate) {
    final date = DateFormat('dd/MM/yyyy').parse(brazilianDate);
    return date;
  }

  static String convertDateTimeToString(DateTime dateTime) {
    final date = DateFormat('dd/MM/yyyy').format(dateTime);
    return date;
  }
}
