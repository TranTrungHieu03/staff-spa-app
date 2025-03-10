part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  serviceLocator.registerLazySingleton<NetworkApiService>(
      () => NetworkApiService(baseUrl: "https://solaceapi.ddnsking.com/api", authService: serviceLocator<AuthService>()));

  //on boarding
  serviceLocator.registerLazySingleton(() => OnboardingBloc());

  //storage
  serviceLocator.registerLazySingleton<LocalStorage>(() => LocalStorage());
  //internet
  serviceLocator.registerFactory(() => InternetConnection());

  //core
  serviceLocator.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator()));

  await _initAuth();
  await _initMenu();
  await _initAppointment();
}

Future<void> _initAuth() async {
  //datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(serviceLocator<NetworkApiService>()))
    //repository
    ..registerFactory<AuthRepository>(() =>
        AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>(), serviceLocator<ConnectionChecker>(), serviceLocator<AuthService>()))

    //use cases
    ..registerFactory(() => Login(serviceLocator()))
    ..registerFactory(() => SignUp(serviceLocator()))
    ..registerFactory(() => VerifyOtp(serviceLocator()))
    ..registerFactory(() => ForgetPassword(serviceLocator()))
    ..registerFactory(() => ResetPassword(serviceLocator()))
    ..registerFactory(() => ResendOtp(serviceLocator()))
    ..registerFactory(() => GetUserInformation(serviceLocator()))
    ..registerFactory(() => Logout(serviceLocator()))

    //bloc
    ..registerLazySingleton(() => AuthBloc(
          login: serviceLocator(),
          signUp: serviceLocator(),
          verifyEvent: serviceLocator(),
          forgetPassword: serviceLocator(),
          resetPassword: serviceLocator(),
          resendOtp: serviceLocator(),
          getUserInformation: serviceLocator(),
          logout: serviceLocator(),
        ))
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

Future<void> _initAppointment() async {
  serviceLocator
    //data src
    ..registerFactory<AppointmentRemoteDataSource>(() => AppointmentRemoteDataSourceImpl(serviceLocator<NetworkApiService>()))
    //repository
    ..registerFactory<AppointmentRepository>(() => AppointmentRepositoryImpl(serviceLocator<AppointmentRemoteDataSource>()))
    ..registerLazySingleton(() => AppointmentBloc(getAppointment: serviceLocator(), checkIn: serviceLocator()))
    //use cases
    ..registerFactory(() => GetAppointment(serviceLocator()))
    ..registerFactory(() => CheckIn(serviceLocator()));
}
