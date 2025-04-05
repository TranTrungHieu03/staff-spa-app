import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:staff_app/core/common/cubit/user/app_user_cubit.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/provider/language_provider.dart';
import 'package:staff_app/core/themes/theme.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:staff_app/features/auth/presentation/screens/on_boarding_screen.dart';
import 'package:staff_app/features/chat/presentation/bloc/user_chat/user_chat_bloc.dart';
import 'package:staff_app/features/home/presentation/bloc/navigator/navigation_bloc.dart';
import 'package:staff_app/init_dependencies.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies and Firebase
  await initDependencies();
  // await NotificationService.init();
  tz.initializeTimeZones();
  // Initialize LanguageProvider
  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguage();

  // Run the app with MultiBlocProvider and LanguageProvider
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<NavigationBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserChatBloc>()),
      ],
      child: ChangeNotifierProvider<LanguageProvider>(
        create: (_) => languageProvider,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          key: ValueKey(languageProvider.locale),
          title: "Solace Spa",
          themeMode: ThemeMode.light,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          navigatorKey: navigatorKey,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [Locale('en'), Locale('vi')],
          locale: languageProvider.locale,
          home: FutureBuilder(
              future: _getStartScreen(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const TLoader();
                } else {
                  return const OnBoardingScreen();
                }
              }),
        );
      },
    );
  }

  Future<void> _getStartScreen(BuildContext context) async {
    final isLogin = await LocalStorage.getData(LocalStorageKey.isLogin);
    final isStaff = await LocalStorage.getData(LocalStorageKey.isStaff);
    final isCompletedOnBoarding = await LocalStorage.getData(LocalStorageKey.isCompletedOnBoarding);
    if (isLogin == 'true' && isStaff == "true") {
      goHome();
    } else if (isCompletedOnBoarding == 'true') {
      goLoginNotBack();
    } else {
      goOnboarding();
    }
  }
}
