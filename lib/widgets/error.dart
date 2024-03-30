import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class ErrorPlaceholder extends StatelessWidget {
  final void Function()? onRetry;
  const ErrorPlaceholder({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 30, color: ErrorColor.error500),
              SizedBox(width: 10),
              Text('Có lỗi xảy ra, vui lòng thử lại sau', style: TextStyle(color: TextColor.textColor900), textAlign: TextAlign.center,)
            ],
          ),
          const SizedBox(height: 10),
          TextButton(onPressed: onRetry, child: const Text('Thử lại'))
        ],
      )
    );
  }
}
