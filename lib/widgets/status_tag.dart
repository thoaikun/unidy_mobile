import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

enum StatusType {
  success,
  error,
  warning,
  info
}

class StatusTag extends StatelessWidget {
  final String label;
  final StatusType type;

  const StatusTag({super.key, required this.label, this.type = StatusType.success});

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: const Text('Đã tham gia'),
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
