import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';
import 'package:smart_fit_test_signal/helpers/time_of_day_helper.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/search_card/search_controller.dart';

class UnityQuery {
  final TimeRange? time;
  final bool closedUnities;
  const UnityQuery({
    this.time,
    this.closedUnities = false,
  });

  bool hasSchedule(List<Schedule> schedules) {
    if (time == null) return true;
    for (final schedule in schedules) {
      if (!schedule.closed &&
          time!.timeRange.$1.isAfterOrSame(schedule.start!) &&
          time!.timeRange.$2.isBeforeOrSame(schedule.end!)) {
        return true;
      }
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnityQuery &&
        other.time == time &&
        other.closedUnities == closedUnities;
  }

  @override
  int get hashCode => time.hashCode ^ closedUnities.hashCode;

  UnityQuery copyWith({
    TimeRange? time,
    bool? closedUnities,
  }) {
    return UnityQuery(
      time: time ?? this.time,
      closedUnities: closedUnities ?? this.closedUnities,
    );
  }
}
