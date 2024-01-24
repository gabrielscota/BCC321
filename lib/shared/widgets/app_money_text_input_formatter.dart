import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppMoneyTextInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter;

  AppMoneyTextInputFormatter({String locale = 'pt_BR'})
      : _formatter = NumberFormat.currency(locale: locale, symbol: 'R\$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    double value = double.tryParse(newValue.text.replaceAll(RegExp(r'[R\$\,]'), '')) ?? 0;

    String newText = _formatter.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
