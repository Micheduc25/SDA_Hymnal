import 'dart:async';

class TimeStream {
  static Stream<DateTime> getCurrentTime() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 10));
      yield DateTime.now();
    }
  }
}
