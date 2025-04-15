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
  await _initChat();
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
    ..registerFactory(() => GetStaffInformation(serviceLocator()))

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
          getStaffInformation: serviceLocator(),
        ))
    //cubit
    ..registerLazySingleton<PasswordCubit>(() => PasswordCubit())
    ..registerLazySingleton<PasswordConfirmCubit>(() => PasswordConfirmCubit())
    ..registerLazySingleton<RememberMeCubit>(() => RememberMeCubit())
    ..registerLazySingleton<PolicyTermCubit>(() => PolicyTermCubit())
    ..registerLazySingleton<PasswordMatchCubit>(() => PasswordMatchCubit());
}

Future<void> _initChat() async {
  //datasource
  serviceLocator
    ..registerFactory<HubRemoteDataSource>(() => HubRemoteDataSourceImpl(serviceLocator<NetworkApiService>()))
    // ..registerFactory<ChatRemoteDataSource>(() => SignalRChatRemoteDataSource(hubUrl: "https://solaceapi.ddnsking.com/chat"))
    //repository
    // ..registerFactory<ChatRepository>(() => ChatRepositoryImpl(serviceLocator<ChatRemoteDataSource>()))
    ..registerFactory<HubRepository>(() => HubRepositoryImpl(serviceLocator<HubRemoteDataSource>()))

    //use cases
    // ..registerFactory(() => ConnectHub(serviceLocator()))
    // ..registerFactory(() => DisconnectHub(serviceLocator()))
    // ..registerFactory(() => SendMessage(serviceLocator()))
    ..registerFactory(() => GetListMessage(serviceLocator()))
    ..registerFactory(() => GetUserChatInfo(serviceLocator()))
    ..registerFactory(() => GetListChannel(serviceLocator()))
    ..registerFactory(() => GetChannel(serviceLocator()))
    // ..registerFactory(() => GetMessages(serviceLocator()))

    //bloc
    ..registerLazySingleton(() => ListMessageBloc(getListMessage: serviceLocator()))
    // ..registerLazySingleton(() => ChatBloc(
    //       getMessages: serviceLocator(),
    //       sendMessage: serviceLocator(),
    //       connect: serviceLocator(),
    //       disconnect: serviceLocator(),
    //     ))
    ..registerLazySingleton(() => UserChatBloc(getUserChatInfo: serviceLocator()))
    ..registerLazySingleton(() => ListChannelBloc(getListChannel: serviceLocator()))
    ..registerLazySingleton(() => ChannelBloc(getChannel: serviceLocator()));
}

Future<void> _initMenu() async {
  serviceLocator.registerLazySingleton(() => NavigationBloc());
}

Future<void> _initAppointment() async {
  serviceLocator
    //data src
    ..registerFactory<AppointmentRemoteDataSource>(() => AppointmentRemoteDataSourceImpl(serviceLocator<NetworkApiService>()))
    ..registerFactory<WorkingRemoteDataSource>(() => WorkingRemoteDataSourceImpl(serviceLocator<NetworkApiService>()))
    //repository
    ..registerFactory<AppointmentRepository>(() => AppointmentRepositoryImpl(serviceLocator<AppointmentRemoteDataSource>()))
    ..registerFactory<WorkingRepository>(() => WorkingRepositoryImpl(serviceLocator<WorkingRemoteDataSource>()))

    //use cases
    ..registerFactory(() => GetAppointment(serviceLocator()))
    ..registerFactory(() => GetListAppointment(serviceLocator()))
    ..registerFactory(() => CheckIn(serviceLocator()))
    ..registerFactory(() => GetShifts(serviceLocator()))
    ..registerFactory(() => RegisterWorkingTime(serviceLocator()))
    ..registerFactory(() => RegisterDayOff(serviceLocator()))
    ..registerFactory(() => GetWorkingTime(serviceLocator()))
    ..registerLazySingleton(() => AppointmentBloc(getAppointment: serviceLocator(), checkIn: serviceLocator()))
    ..registerLazySingleton(() => ShiftBloc(registerWorkingTime: serviceLocator(), registerDayOff: serviceLocator()))
    ..registerLazySingleton(() => ListShiftBloc(getShifts: serviceLocator()))
    ..registerLazySingleton(() => WorkingTimeBloc(getWorkingTime: serviceLocator()))
    ..registerLazySingleton(() => ImageBloc())
    ..registerLazySingleton(() => ListAppointmentBloc(getListAppointment: serviceLocator()));
}
