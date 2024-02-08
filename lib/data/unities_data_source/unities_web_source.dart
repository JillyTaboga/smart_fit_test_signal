import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_fit_test_signal/data/http_client/http_client.dart';
import 'package:smart_fit_test_signal/data/unities_data_source/unities_data_source.dart';
import 'package:smart_fit_test_signal/domain/entities/rules_entity.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';

@Injectable(as: UnitiesDataSource)
class UnitiesWebSource implements UnitiesDataSource {
  const UnitiesWebSource(this.client);
  final HttpClient client;

  @override
  Future<List<UnityEntity>> getUnities() async {
    final response = await client.get(
      'https://test-frontend-developer.s3.amazonaws.com/data/locations.json',
    );
    final data = response.data as Map;
    final unitiesJson = data['locations'] as List;
    final unities =
        unitiesJson.where((element) => element['opened'] != null).map(
      (e) {
        final schedulesJson =
            e['schedules'] == null ? [] : e['schedules'] as List;
        final schedules = schedulesJson.map((s) {
          final parsed = _timesFromBizarreJson(s['hour']);
          return Schedule(
            label: s['weekdays'],
            start: parsed.$1,
            end: parsed.$2,
            obs: parsed.$3,
          );
        }).toList();
        return UnityEntity(
          id: e['id'],
          status: switch (e['opened'] as bool) {
            true => Status.open,
            false => Status.closed,
          },
          name: e['title'],
          address: e['content'],
          rules: [
            if (e['mask'] != null) RulesEntity.mask(e['mask'] == 'required'),
            if (e['towel'] != null) RulesEntity.towel(e['towel'] == 'required'),
            if (e['fountain'] != null)
              RulesEntity.fountain(e['fountain'] == 'partial'),
            if (e['locker_room'] != null)
              RulesEntity.lockerRoom(switch (e['locker_room']) {
                'allowed' => PermissionStatus.cleared,
                'closed' => PermissionStatus.closed,
                _ => PermissionStatus.partial,
              }),
          ],
          schedules: schedules,
        );
      },
    ).toList();
    return unities;
  }
}

(TimeOfDay? start, TimeOfDay? end, String? obs) _timesFromBizarreJson(
    String json) {
  if (json == 'Fechada') return (null, null, null);
  if (json.contains('às')) {
    final edited = json.replaceAll(' às ', ' ');
    final hoursString = edited.split(' ');
    try {
      final hours = hoursString.map((e) {
        final divided = e.split('h');
        final hour = int.parse(divided.first);
        final minute = (divided.length > 1 && divided.last.isNotEmpty)
            ? int.parse(divided.last)
            : 0;
        return TimeOfDay(hour: hour, minute: minute);
      }).toList();
      return (hours.first, hours.last, null);
    } catch (e) {
      log('Não foi possível fazer o parse da agenda', error: json);
    }
  }
  return (null, null, json);
}
