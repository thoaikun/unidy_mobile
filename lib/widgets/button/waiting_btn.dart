import 'package:flutter/material.dart';
import 'dart:async';

class WaitingButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Duration duration;

  const WaitingButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.duration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  WaitingButtonState createState() =>
      WaitingButtonState();
}

class WaitingButtonState extends State<WaitingButton> {
  bool _isDisabled = false;
  Timer? _countdownTimer;
  String _remainingTime = '0';

  void _onPressed() {
    if (!_isDisabled) {
      widget.onPressed();
      setState(() {
        _isDisabled = true;
        _remainingTime = widget.duration.inSeconds.toString();
        _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          int remainingSeconds = int.parse(_remainingTime) - 1;
          if (remainingSeconds <= 0) {
            timer.cancel();
            setState(() {
              _isDisabled = false;
              _remainingTime = '0';
            });
          } else {
            setState(() {
              _remainingTime = remainingSeconds.toString();
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isDisabled ? null : _onPressed,
      child: Text(_isDisabled ? 'Gửi lại sau $_remainingTime' : widget.text),
    );
  }
}
