import 'package:intl/intl.dart';

String formatCurrency(double amount,
    {String locale = 'vi', String currencySymbol = '₫'}) {
  final formatter =
      NumberFormat.currency(locale: locale, symbol: currencySymbol);
  return formatter.format(amount);
}
