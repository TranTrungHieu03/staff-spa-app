part of 'exports_navigators.dart';

final navigatorKey = GlobalKey<NavigatorState>();

goSignUp() async {
  Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                  BlocProvider(create: (_) => serviceLocator<PasswordConfirmCubit>()),
                  BlocProvider(create: (_) => serviceLocator<PolicyTermCubit>()),
                  BlocProvider(create: (_) => serviceLocator<PasswordMatchCubit>()),
                ],
                child: const SignUpScreen(),
              )),
      (Route<dynamic> route) => false);
}

goForgotPassword() async {
  Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
}

goSetPassword(String email) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                  BlocProvider(create: (_) => serviceLocator<PasswordConfirmCubit>()),
                  BlocProvider(create: (_) => serviceLocator<PasswordMatchCubit>()),
                ],
                child: SetPasswordScreen(email: email),
              )));
}

goHome() async {
  navigatorKey.currentContext!.read<NavigationBloc>().add(ChangeSelectedIndexEvent(0));
  Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const NavigationMenu()), (Route<dynamic> route) => false);
}

goLogin() async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                  BlocProvider(create: (_) => serviceLocator<RememberMeCubit>()),
                ],
                child: const LoginScreen(),
              )));
}

goLoginNotBack() async {
  Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                BlocProvider(create: (_) => serviceLocator<RememberMeCubit>()),
              ], child: const LoginScreen())),
      (Route<dynamic> route) => false);
}

goProfile() async {
  Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const ProfileScreen()));
}

goSuccess(String title, String subTitle, VoidCallback onPressed, String image) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => SuccessScreen(
                title: title,
                subTitle: subTitle,
                onPressed: onPressed,
                image: image,
              )));
}

goVerify(String email, int statePage) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => VerifyScreen(
                email: email,
                statePage: statePage,
              )));
}

goOnboarding() async {
  Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
}

goScanner() async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => serviceLocator<AppointmentBloc>(),
                child: const CheckInArrivedScreen(),
              )));
}

goChatRoom(String channelId, String userId) async {
  Navigator.push(
      navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => WrapperChatRoom(channelId: channelId, userId: userId)));
}
