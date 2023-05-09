import 'package:intl/intl.dart';

String amountFormat(int amount) {
  var format = NumberFormat('0,000');
  if (amount.toString().length > 3) {
    return format.format(amount);
  } else {
    return amount.toString();
  }
}