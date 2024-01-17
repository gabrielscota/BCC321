import 'package:intl/intl.dart';

class CurrencyFormat {
  static String formatCentsToReal(int cents) {
    final real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return real.format(cents / 100);
  }
}
