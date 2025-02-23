import 'package:intl/intl.dart';

String formatCurrency(double amount,
    {String locale = 'vi', String currencySymbol = '₫'}) {
  final formatter =
      NumberFormat.currency(locale: locale, symbol: currencySymbol);
  return formatter.format(amount);
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString); // Chuyển chuỗi thành DateTime
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime); // Định dạng
  return formattedDate;
}
