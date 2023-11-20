import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

enum StatusType {
  success,
  error,
  warning,
  info
}

class StatusTag extends StatelessWidget {
  final String label;
  final StatusType? type;

  const StatusTag({super.key, required this.label, this.type });

  Color _getStatusBackgroundColor() {
    switch(type) {
      case StatusType.success:
        return SuccessColor.success100;
      case StatusType.error:
        return ErrorColor.error100;
      case StatusType.warning:
        return WarningColor.warning100;
      case StatusType.info:
        return InfoColor.info100;
      default:
        return Colors.white;
    }
  }

  Color _getStatusLabelColor() {
    switch(type) {
      case StatusType.success:
        return SuccessColor.success500;
      case StatusType.error:
        return ErrorColor.error500;
      case StatusType.warning:
        return WarningColor.warning500;
      case StatusType.info:
        return InfoColor.info500;
      default:
        return TextColor.textColor800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label.toUpperCase()),
      labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: _getStatusLabelColor()),
      labelPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: -4),
      color: MaterialStatePropertyAll(_getStatusBackgroundColor()),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(width: 1, color: _getStatusLabelColor()),
    );
  }
}
