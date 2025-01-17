import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String? formatTime(DateTime? dateTime, String format) {
    if (dateTime == null) return null;
    final formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  static String calculateTimeDifference(String? time) {
    if (time == null) return '';

    DateFormat format = DateFormat('yyyy-MM-ddTHH:mm:ss', Intl.systemLocale);
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

  static String calculateTimeRemain(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) return '';

    DateFormat format = DateFormat('yyyy-MM-ddTHH:mm:ss', Intl.systemLocale);
    DateTime start = format.parse(startTime);
    DateTime end = format.parse(endTime);

    Duration difference = end.difference(start);

    if (difference.inDays > 0) {
      return 'Còn lại: ${difference.inDays} ngày';
    } else if (difference.inHours > 0) {
      return 'Còn lại: ${difference.inHours} giờ';
    } else if (difference.inMinutes > 0) {
      return 'Còn lại: ${difference.inMinutes} phút';
    } else {
      return 'Hết hạn';
    }
  }

  static String formatCurrency(dynamic value) {
    if (value is String) {
      return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(double.parse(value));
    }
    return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(value);
  }

  static String deFormatCurrency(String value) {
    // remove . and đ from the string
    return value.replaceAll('.', '').replaceAll('đ', '');
  }
}

String getImageUrl(String path) {
  if (path.contains(dotenv.env['S3_BASE_URL']!)) return path;
  return '${dotenv.env['S3_BASE_URL']}$path';
}

