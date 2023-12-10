import 'package:intl/intl.dart';

class Formatter {
  static String? formatTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    final formatter = DateFormat('dd/MM/yyyy - HH:mm');
    return formatter.format(dateTime);
  }

  static String calculateTimeDifference(String? time) {
    if (time == null) return '';

    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime parameterTime = format.parseStrict(time);
    DateTime currentTime = DateTime.now();

    // Check if parameter time and current time are in the same year
    if (parameterTime.year == currentTime.year) {
      // Check if they are in the same day
      if (parameterTime.day == currentTime.day &&
          parameterTime.month == currentTime.month) {
        // Check if they are in the same hour
        if (parameterTime.hour == currentTime.hour) {
          // Calculate the difference in minutes
          int differenceInMinutes = currentTime.difference(parameterTime).inMinutes;
          return '$differenceInMinutes phút trước';
        } else {
          // Calculate the difference in hours
          int differenceInHours = currentTime.difference(parameterTime).inHours;
          return '$differenceInHours giờ trước';
        }
      } else {
        // Calculate the difference in days
        int differenceInDays = currentTime.difference(parameterTime).inDays;
        return '$differenceInDays ngày trước';
      }
    } else {
      // Calculate the difference in years
      int differenceInYears = currentTime.year - parameterTime.year;
      return '$differenceInYears năm trước';
    }
  }

}