// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/http_client/dio_client.dart' as _i4;
import '../data/http_client/http_client.dart' as _i3;
import '../data/unities_data_source/unities_data_source.dart' as _i7;
import '../data/unities_data_source/unities_web_source.dart' as _i8;
import '../domain/repositories/unities_repository.dart' as _i9;
import '../presentation/global_controllers/locale_controller.dart' as _i5;
import '../presentation/search_unity/screen/unities_controller.dart' as _i10;
import '../presentation/search_unity/search_card/search_controller.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.HttpClient>(() => _i4.DioClient());
    gh.singleton<_i5.LocaleController>(_i5.LocaleController());
    gh.factory<_i6.SearchFormController>(() => _i6.SearchFormController());
    gh.factory<_i7.UnitiesDataSource>(
        () => _i8.UnitiesWebSource(gh<_i3.HttpClient>()));
    gh.factory<_i9.UnitiesRepository>(
        () => _i9.UnitiesRepository(gh<_i7.UnitiesDataSource>()));
    gh.factory<_i10.UnitiesController>(
        () => _i10.UnitiesController(gh<_i9.UnitiesRepository>()));
    return this;
  }
}
