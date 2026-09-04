import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _vndFormat = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
    decimalDigits: 0,
  );

  static final NumberFormat _vndFormatWithSymbolName = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'VND',
    decimalDigits: 0,
  );

  static String formatVND(num amount) {
    return _vndFormat.format(amount);
  }

  static String formatVNDWithCode(num amount) {
    return _vndFormatWithSymbolName.format(amount);
  }

  static String formatMasked(num amount, bool isMasked) {
    if (isMasked) {
      return '****** đ';
    }
    return formatVND(amount);
  }
}
