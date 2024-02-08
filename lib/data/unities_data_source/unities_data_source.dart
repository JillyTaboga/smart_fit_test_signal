import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';

abstract interface class UnitiesDataSource {
  Future<List<UnityEntity>> getUnities();
}
