import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toTitle() {
    if (this.isToday()) {
      return "Today";
    } else if (this.isYesterday()) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(this);
    }
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}
