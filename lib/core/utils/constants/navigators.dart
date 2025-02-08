part of 'exports_navigators.dart';

final navigatorKey = GlobalKey<NavigatorState>();

goSignUp() async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                  BlocProvider(
                      create: (_) => serviceLocator<PasswordConfirmCubit>()),
                  BlocProvider(
                      create: (_) => serviceLocator<PolicyTermCubit>()),
                  BlocProvider(
                      create: (_) => serviceLocator<PasswordMatchCubit>()),
                ],
                child: const SignUpScreen(),
              )));
}

goForgotPassword() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
}

goProductDetail(String id) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => ProductDetailScreen(productId: id)));
}

goSetPassword(String email) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                  BlocProvider(
                      create: (_) => serviceLocator<PasswordConfirmCubit>()),
                  BlocProvider(
                      create: (_) => serviceLocator<PasswordMatchCubit>()),
                ],
                child: SetPasswordScreen(email: email),
              )));
}

goBookingDetail(String id) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => BookingDetailScreen(bookingId: id)));
}

goCart() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const MyCartScreen()));
}

goHome() async {
  navigatorKey.currentContext!
      .read<NavigationBloc>()
      .add(ChangeSelectedIndexEvent(0));
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const NavigationMenu()));
}

goLogin() async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => serviceLocator<PasswordCubit>()),
                  BlocProvider(
                      create: (_) => serviceLocator<RememberMeCubit>()),
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

goCheckout() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const CheckoutScreen()));
}

goShipmentInfo() async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => const ShipmentInformationScreen()));
}

goServiceHistory() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const ServiceHistoryScreen()));
}

goSearch() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const SearchScreen()));
}

goHistory() async {
  Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const HistoryScreen()),
      (Route<dynamic> route) => false);
}

goProfile() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const ProfileScreen()));
}

goServiceDetail(String id) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => ServiceDetailScreen(
                serviceId: id,
              )));
}

goSuccess(
    String title, String subTitle, VoidCallback onPressed, String image) async {
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

goServiceBooking() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const BookingServiceScreen()));
}

goServiceCheckout() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const CheckoutServiceScreen()));
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

goChat() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const ChatAiScreen()));
}

goFeedback() async {
  Navigator.push(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const FeedbackScreen()));
}

goStatusService(String title, String content, Widget value, String image,
    Color color) async {
  Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => StatusServiceScreen(
              title: title,
              content: content,
              value: value,
              image: image,
              color: color)));
}
