import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:smart_fit_test_signal/domain/entities/failures.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';
import 'package:smart_fit_test_signal/domain/repositories/unities_repository.dart';

@injectable
class UnitiesController {
  UnitiesController(this._repository);
  final UnitiesRepository _repository;

  final state = signal<UnitiesStates>(UnitiesStateLoading());

  load() async {
    state.set(UnitiesStateLoading());
    final result = await _repository.getUnities();
    result.fold(
      (err) => state.set(UnitiesStateError(err)),
      (data) => state.set(UnitiesStateReady(data)),
    );
  }
}

sealed class UnitiesStates {
  const UnitiesStates();
}

class UnitiesStateLoading extends UnitiesStates {}

class UnitiesStateError extends UnitiesStates {
  const UnitiesStateError(this.error);
  final Failure error;
}

class UnitiesStateReady extends UnitiesStates {
  const UnitiesStateReady(this.data);
  final List<UnityEntity> data;
}
