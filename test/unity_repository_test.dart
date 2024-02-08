import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_fit_test_signal/data/unities_data_source/unities_data_source.dart';
import 'package:smart_fit_test_signal/domain/entities/failures.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';
import 'package:smart_fit_test_signal/domain/repositories/unities_repository.dart';

class MockUnitiesDataSource extends Mock implements UnitiesDataSource {}

void main() {
  final UnitiesDataSource dataSource = MockUnitiesDataSource();
  final UnitiesRepository repository = UnitiesRepository(dataSource);

  final fakeList = [
    UnityEntity(
      id: 0,
      status: Status.open,
      name: 'name',
      address: 'address',
      rules: [],
      schedules: [],
    ),
  ];

  test('Test for success', () async {
    when(
      () => dataSource.getUnities(),
    ).thenAnswer(
      (_) async => fakeList,
    );
    final result = await repository.getUnities();
    expect(
      result.right,
      fakeList,
    );
  });

  test('Test for error', () async {
    when(
      () => dataSource.getUnities(),
    ).thenThrow(const SocketException.closed());
    final result = await repository.getUnities();
    expect(
      result.left,
      const TypeMatcher<Failure>(),
    );
  });
}
