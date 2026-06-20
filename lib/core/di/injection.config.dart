// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/analytics/data/repositories/firebase_analytics_repository.dart'
    as _i45;
import '../../features/analytics/domain/repositories/analytics_repository.dart'
    as _i1044;
import '../../features/analytics/domain/usecases/log_profile_swapped_usecase.dart'
    as _i427;
import '../../features/crash_reporting/data/repositories/firebase_crash_reporting_repository.dart'
    as _i248;
import '../../features/crash_reporting/domain/repositories/crash_reporting_repository.dart'
    as _i1027;
import '../../features/events/data/repositories/event_repository_impl.dart'
    as _i967;
import '../../features/events/domain/repositories/event_repository.dart'
    as _i199;
import '../../features/events/domain/usecases/event_usecases.dart' as _i634;
import '../../features/profiles/data/repositories/profile_repository_impl.dart'
    as _i275;
import '../../features/profiles/domain/repositories/profile_repository.dart'
    as _i428;
import '../../features/profiles/domain/usecases/profile_usecases.dart' as _i769;
import '../../providers/calendar_provider.dart' as _i136;
import '../../providers/events_provider.dart' as _i406;
import '../../providers/profile_provider.dart' as _i975;
import '../../providers/todo_provider.dart' as _i68;
import '../../services/events_api_service.dart' as _i870;
import '../../services/profile_local_datasource.dart' as _i762;
import '../../services/secure_storage_service.dart' as _i494;
import '../network/auth_interceptor.dart' as _i908;
import '../network/dio_client.dart' as _i667;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i136.CalendarProvider>(() => _i136.CalendarProvider());
    gh.singleton<_i762.ProfileLocalDatasource>(
      () => _i762.ProfileLocalDatasource(),
    );
    gh.singleton<_i494.SecureStorageService>(
      () => _i494.SecureStorageService(),
    );
    gh.lazySingleton<_i1044.AnalyticsRepository>(
      () => _i45.FirebaseAnalyticsRepository(),
    );
    gh.lazySingleton<_i1027.CrashReportingRepository>(
      () => _i248.FirebaseCrashReportingRepository(),
    );
    gh.lazySingleton<_i428.ProfileRepository>(
      () => _i275.ProfileRepositoryImpl(gh<_i762.ProfileLocalDatasource>()),
    );
    gh.factory<_i427.LogProfileSwappedUseCase>(
      () => _i427.LogProfileSwappedUseCase(gh<_i1044.AnalyticsRepository>()),
    );
    gh.singleton<_i908.AuthInterceptor>(
      () => _i908.AuthInterceptor(gh<_i494.SecureStorageService>()),
    );
    gh.factory<_i769.GetProfilesUseCase>(
      () => _i769.GetProfilesUseCase(gh<_i428.ProfileRepository>()),
    );
    gh.factory<_i769.AddTodoUseCase>(
      () => _i769.AddTodoUseCase(gh<_i428.ProfileRepository>()),
    );
    gh.factory<_i769.ToggleTodoUseCase>(
      () => _i769.ToggleTodoUseCase(gh<_i428.ProfileRepository>()),
    );
    gh.factory<_i769.DeleteTodoUseCase>(
      () => _i769.DeleteTodoUseCase(gh<_i428.ProfileRepository>()),
    );
    gh.factory<_i769.GetTodosForProfileUseCase>(
      () => _i769.GetTodosForProfileUseCase(gh<_i428.ProfileRepository>()),
    );
    gh.factory<_i769.SeedDefaultProfilesUseCase>(
      () => _i769.SeedDefaultProfilesUseCase(gh<_i428.ProfileRepository>()),
    );
    gh.factory<_i68.TodoProvider>(
      () => _i68.TodoProvider(
        gh<_i769.GetTodosForProfileUseCase>(),
        gh<_i769.AddTodoUseCase>(),
        gh<_i769.ToggleTodoUseCase>(),
        gh<_i769.DeleteTodoUseCase>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => networkModule.dio(gh<_i908.AuthInterceptor>()),
    );
    gh.singleton<_i870.EventsApiService>(
      () => _i870.EventsApiService(gh<_i361.Dio>()),
    );
    gh.factory<_i975.ProfileProvider>(
      () => _i975.ProfileProvider(
        gh<_i769.GetProfilesUseCase>(),
        gh<_i769.SeedDefaultProfilesUseCase>(),
        gh<_i427.LogProfileSwappedUseCase>(),
      ),
    );
    gh.lazySingleton<_i199.EventRepository>(
      () => _i967.EventRepositoryImpl(gh<_i870.EventsApiService>()),
    );
    gh.factory<_i634.GetEventsUseCase>(
      () => _i634.GetEventsUseCase(gh<_i199.EventRepository>()),
    );
    gh.factory<_i634.GetEventByIdUseCase>(
      () => _i634.GetEventByIdUseCase(gh<_i199.EventRepository>()),
    );
    gh.factory<_i406.EventsProvider>(
      () => _i406.EventsProvider(
        gh<_i634.GetEventsUseCase>(),
        gh<_i634.GetEventByIdUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i667.NetworkModule {}
