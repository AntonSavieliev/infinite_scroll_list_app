import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite_scroll_list_app/core/platform/network_info.dart';
import 'package:infinite_scroll_list_app/feature/data/datasources/photo_local_data_source.dart';
import 'package:infinite_scroll_list_app/feature/data/datasources/photo_local_data_source_impl.dart';
import 'package:infinite_scroll_list_app/feature/data/datasources/photo_remote_data_source.dart';
import 'package:infinite_scroll_list_app/feature/data/datasources/photo_remote_data_source_impl.dart';
import 'package:infinite_scroll_list_app/feature/data/db/database.dart';
import 'package:infinite_scroll_list_app/feature/data/repositories/photo_repository_impl.dart';
import 'package:infinite_scroll_list_app/feature/domain/repositories/photo_repository.dart';
import 'package:infinite_scroll_list_app/feature/domain/usecases/get_all_photos.dart';
import 'package:infinite_scroll_list_app/feature/domain/usecases/update_photo.dart';
import 'package:infinite_scroll_list_app/feature/presentation/bloc/photo_list_cubit/photo_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(() => PhotoListCubit(
        getAllPhotos: sl<GetAllPhotos>(),
        updatePhoto: sl<UpdatePhoto>(),
        sharedPreferences: sl(),
        networkInfo: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => GetAllPhotos(sl()));
  sl.registerLazySingleton(() => UpdatePhoto(sl()));

  // Repository
  sl.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<PhotoRemoteDataSource>(
        () => PhotoRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<PhotoLocalDataSource>(
        () => PhotoLocalDataSourceImpl(sharedPreferences: sl(), dbProvider: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //DB
  final dBProvider = DBProvider.db;
  sl.registerLazySingleton(() => dBProvider);
}
