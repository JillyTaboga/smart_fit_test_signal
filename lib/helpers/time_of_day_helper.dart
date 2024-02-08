import 'package:flutter/material.dart';

extension TimeDay on TimeOfDay {
  bool isBeforeOrSame(TimeOfDay otherTime) {
    if (hour < otherTime.hour) return true;
    if (hour == otherTime.hour && minute <= otherTime.minute) return true;
    return false;
  }

  bool isAfterOrSame(TimeOfDay otherTime) {
    if (hour > otherTime.hour) return true;
    if (hour == otherTime.hour && minute >= otherTime.minute) return true;
    return false;
  }
}
