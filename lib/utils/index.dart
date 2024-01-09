import 'dart:async';

Function debounce(void Function() callback, [int delay = 100]) {
  Timer? timer;
  return () {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: delay), callback);
  };
}