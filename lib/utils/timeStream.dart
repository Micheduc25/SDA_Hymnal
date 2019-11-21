import 'dart:async';

class TimeStream {
  static Stream<DateTime> getCurrentTime() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 4));
      yield DateTime.now();
    }
  }

  static isLeapYear(int year) {
    if (year % 4 == 0 && year % 100 != 0) {
      return true;
    } else if (year % 4 == 0 && year % 100 == 0) {
      if (year % 400 == 0)
        return true;
      else
        return false;
    }

    return false;
  }

  static int daysInMonth(int month, int year) {
    if (month == 9 || month == 4 || month == 6 || month == 10) {
      return 30;
    } else if (month == 2) {
      if (isLeapYear(year)) {
        return 29;
      } else {
        return 28;
      }
    } else {
      return 31;
    }
  }

  static int daysInYear(int year) {
    if (isLeapYear(year)) {
      return 366;
    } else {
      return 365;
    }
  }
}
