import 'package:intl/intl.dart';

class Formatter {
  static String? formatTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    final formatter = DateFormat('dd/MM/yyyy - HH:mm');
    return formatter.format(dateTime);
  }
}