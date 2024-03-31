import 'package:rxdart/rxdart.dart';

class Debounce {
  BehaviorSubject<void> debounce = BehaviorSubject<void>();
  void Function()? callback;
  int delay;

  Debounce({required this.callback, this.delay = 100}) {
    debounce.debounceTime(Duration(milliseconds: delay)).listen((_) {
      callback?.call();
    });
  }

  void dispose() {
    debounce.close();
  }

  void call() {
    debounce.add(null);
  }
}