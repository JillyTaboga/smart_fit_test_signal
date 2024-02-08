import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_fit_test_signal/data/unities_data_source/unities_data_source.dart';
import 'package:smart_fit_test_signal/domain/entities/failures.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';

@injectable
final class UnitiesRepository {
  const UnitiesRepository(this.dataSource);
  final UnitiesDataSource dataSource;

  Future<RepositoryResponse<List<UnityEntity>>> getUnities() async {
    try {
      final result = await dataSource.getUnities();
      return right(result);
    } on SocketException catch (e, s) {
      return left(ConnectionFailure(stackTrace: s));
    } catch (e, s) {
      return left(UnitiesGetFailure(stackTrace: s));
    }
  }
}

final class UnitiesGetFailure extends Failure {
  const UnitiesGetFailure({super.stackTrace}) : super('unitiesGetError');

  @override
  String text(BuildContext context) {
    return i10n(context).errorsUnitiesGetError;
  }
}
