import 'dart:ui';

import 'package:todo_app/res/colors.dart';

class Helper {
  static Color getPriorityColor(int priority) {
    return priority == 1
        ? highPriority
        : priority == 2
            ? midPriority
            : lowPriority;
  }

  static String getPriorityString(int priority) {
    return priority == 1
        ? "High Priority"
        : priority == 2
            ? "Medium Priority"
            : "Low Priority";
  }

  static String getFormattedTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "--:--:--";
    }

    dateTime.add(const Duration(hours: 5)).add(const Duration(minutes: 30));

    final now = dateTime ?? DateTime.now();
    final hour = (now.hour % 12) == 0 ? 12 : (now.hour % 12);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  static String getFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "--:--:----";
    }

    final now = dateTime ?? DateTime.now();
    return '${now.day} ${getMonth(now.month)} ${now.year}';
  }

  static getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid';
    }
  }
}
