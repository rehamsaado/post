import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post/core/network/network_info.dart';
import 'package:post/feature/post/data/datasource/post_local_data_source.dart';
import 'package:post/feature/post/data/datasource/post_remote_data_source.dart';
import 'package:post/feature/post/data/repositories/post_repository_impl.dart';
import 'package:post/feature/post/domain/repositories/posts_repository.dart';
import 'package:post/feature/post/domain/usecase/add_post.dart';
import 'package:post/feature/post/domain/usecase/delete_post.dart';
import 'package:post/feature/post/domain/usecase/get_all_posts.dart';
import 'package:post/feature/post/domain/usecase/update_post.dart';
import 'package:post/feature/post/presentation/bloc/add_delete_bloc/add_delete_update_post_bloc.dart';
import 'package:post/feature/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //feature_posts

  //bloc

  sl.registerFactory(() => PostsBloc(
        getAllPosts: sl(),
      ));

  sl.registerFactory(
    () => AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  //UseCases

  sl.registerLazySingleton(
    () => GetAllPostsUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AddPostUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeletePostUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdatePostUseCase(
      sl(),
    ),
  );

  //Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  //DataSources

  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  //!Core

  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl(),));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance());

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker);
}
