import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';

@injectable
class SearchFormController {
  final time = signal<TimeRange?>(null);
  final closedUnities = signal(false);

  changeTime(TimeRange newTime) {
    time.set(newTime);
  }

  changeClosedUnities() {
    closedUnities.set(!closedUnities.value);
  }

  clean() {
    time.set(null);
    closedUnities.set(false);
  }
}

enum TimeRange {
  morning,
  afternoon,
  evening;

  String label(BuildContext context) {
    return switch (this) {
      TimeRange.morning => i10n(context).formMorning,
      TimeRange.afternoon => i10n(context).formAfternoon,
      TimeRange.evening => i10n(context).formNight,
    };
  }

  String time(BuildContext context) {
    return switch (this) {
      TimeRange.morning => i10n(context).formMorningTime,
      TimeRange.afternoon => i10n(context).formAfternoonTime,
      TimeRange.evening => i10n(context).formNightTime,
    };
  }

  (TimeOfDay, TimeOfDay) get timeRange {
    return switch (this) {
      TimeRange.morning => (
          const TimeOfDay(hour: 6, minute: 0),
          const TimeOfDay(hour: 12, minute: 0),
        ),
      TimeRange.afternoon => (
          const TimeOfDay(hour: 12, minute: 1),
          const TimeOfDay(hour: 18, minute: 0),
        ),
      TimeRange.evening => (
          const TimeOfDay(hour: 18, minute: 1),
          const TimeOfDay(hour: 23, minute: 0),
        ),
    };
  }
}
