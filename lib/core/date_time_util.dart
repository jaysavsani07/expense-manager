import 'package:expense_manager/extension/datetime_extension.dart';

class DateTimeUtil {
  static getStartDateTime(int cycleDate) {
    DateTime currentDate = DateTime.now().copyWith(hour: 0, minute: 0, second: 0);

    if (currentDate.day == 1) {
      return currentDate.copyWith(day: cycleDate);
    } else {
      if (currentDate.day > cycleDate) {
        return currentDate.copyWith(day: cycleDate);
      } else {
        return currentDate.copyWith(
            month: currentDate.month - 1, day: cycleDate);
      }
    }
  }

  static getEndDateTime(int cycleDate) {
    DateTime currentDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    if (currentDate.day == 1) {
      return currentDate.copyWith(
          day: currentDate.copyWith(month: currentDate.month + 1, day: 0).day);
    } else {
      if (currentDate.day > cycleDate) {
        return currentDate.copyWith(
            month: currentDate.month + 1, day: cycleDate - 1);
      } else {
        return currentDate.copyWith(
            month: currentDate.month, day: cycleDate - 1);
      }
    }
  }
}
