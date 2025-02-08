part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<NetworkApiService>(
      () => NetworkApiService(baseUrl: "https://solaceapi.ddnsking.com/api"));

  //on boarding
  serviceLocator.registerLazySingleton(() => OnboardingBloc());

  //storage

  //internet
  serviceLocator.registerFactory(() => InternetConnection());

  //core
  serviceLocator.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));

  await _initAuth();
  await _initMenu();
  await _initProduct();
}

Future<void> _initAuth() async {
  //datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator<NetworkApiService>()))
    //repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
        serviceLocator<ConnectionChecker>()))

    //use cases
    ..registerFactory(() => Login(serviceLocator()))
    ..registerFactory(() => SignUp(serviceLocator()))
    ..registerFactory(() => VerifyOtp(serviceLocator()))
    ..registerFactory(() => ForgetPassword(serviceLocator()))
    ..registerFactory(() => ResetPassword(serviceLocator()))
    ..registerFactory(() => ResendOtp(serviceLocator()))

    //bloc
    ..registerLazySingleton(() => AuthBloc(serviceLocator()))
    //cubit
    ..registerLazySingleton<PasswordCubit>(() => PasswordCubit())
    ..registerLazySingleton<PasswordConfirmCubit>(() => PasswordConfirmCubit())
    ..registerLazySingleton<RememberMeCubit>(() => RememberMeCubit())
    ..registerLazySingleton<PolicyTermCubit>(() => PolicyTermCubit())
    ..registerLazySingleton<PasswordMatchCubit>(() => PasswordMatchCubit());
}

Future<void> _initMenu() async {
  serviceLocator.registerLazySingleton(() => NavigationBloc());
}

Future<void> _initProduct() async {
  serviceLocator
      .registerLazySingleton<CheckboxCartCubit>(() => CheckboxCartCubit());
}
