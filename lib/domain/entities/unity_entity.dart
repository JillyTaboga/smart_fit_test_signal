import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_fit_test_signal/domain/entities/rules_entity.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';

class UnityEntity {
  final int id;
  final Status status;
  final String name;
  final String address;
  final List<RulesEntity> rules;
  final List<Schedule> schedules;
  UnityEntity({
    required this.id,
    required this.status,
    required this.name,
    required this.address,
    required this.rules,
    required this.schedules,
  });

  bool get isOpened => status == Status.open;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnityEntity &&
        other.id == id &&
        other.status == status &&
        other.name == name &&
        other.address == address &&
        listEquals(other.rules, rules) &&
        listEquals(other.schedules, schedules);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        name.hashCode ^
        address.hashCode ^
        rules.hashCode ^
        schedules.hashCode;
  }
}

class Schedule {
  final String label;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final String? obs;
  const Schedule({
    required this.label,
    this.start,
    this.end,
    this.obs,
  });

  bool get closed => start == null || end == null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Schedule &&
        other.label == label &&
        other.start == start &&
        other.end == end &&
        other.obs == obs;
  }

  @override
  int get hashCode {
    return label.hashCode ^ start.hashCode ^ end.hashCode ^ obs.hashCode;
  }
}

enum Status {
  open,
  closed;

  String label(BuildContext context) {
    return this == Status.open ? i10n(context).opened : i10n(context).closed;
  }

  Color get color {
    return this == Status.open ? AppColors.green : AppColors.red;
  }
}
