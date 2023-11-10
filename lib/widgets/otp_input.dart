import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  final int numberOfDigit;
  final void Function(String)? onComplete;

  const OtpInput({
    super.key,
    this.numberOfDigit = 4,
    required this.onComplete
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  List<String> digits =List.filled(6, '');
  List<TextEditingController> inputControllers = [];
  List<FocusNode> inputFocusNodes = [
    FocusNode(debugLabel: '0'),
    FocusNode(debugLabel: '1'),
    FocusNode(debugLabel: '2'),
    FocusNode(debugLabel: '3'),
    FocusNode(debugLabel: '4'),
    FocusNode(debugLabel: '5'),
  ];
  List<FocusAttachment> inputFocusAttach = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    for (int i=0; i < 6; i++) {
      inputControllers.add(TextEditingController());
      inputFocusAttach.add(inputFocusNodes[i].attach(context, onKey: _handlePressKey));
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (int i=0; i < 6; i++) {
     inputFocusNodes[i].dispose();
    }
  }

  KeyEventResult _handlePressKey(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        int index = int.parse(node.debugLabel ?? '0');
        inputControllers[index].text = '';
        FocusScope.of(context).previousFocus();
      }
      else if (_isDigit(event)) {
        int index = int.parse(node.debugLabel ?? '0');
        inputControllers[index].text = event.logicalKey.keyLabel;
        bool isFinalInput = index == 5;
        if (isFinalInput) {
          String otpValue = '';
          for (int i=0; i < 6; i++) {
            otpValue += inputControllers[i].text;
          }
          widget.onComplete!(otpValue);
        }
        FocusScope.of(context).nextFocus();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  bool _isDigit(RawKeyDownEvent event) {
    return RegExp(r'[0-9]').hasMatch(event.logicalKey.keyLabel);
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> inputs = [];

    for (int i=0; i < widget.numberOfDigit; i++) {
      inputs.add(_buildDigitInput(context, i));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: inputs,
    );
  }

  Widget _buildDigitInput(BuildContext context, int key) {
    return SizedBox(
      key: Key(key.toString()),
      width: 50,
      height: 80,
      child: TextField(
        controller: inputControllers[key],
        focusNode: inputFocusNodes[key],
        style: Theme.of(context).textTheme.headlineMedium,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
