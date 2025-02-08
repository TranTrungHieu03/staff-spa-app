import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TDeviceUtils {
  void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  bool isLandscapeOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  bool isPortraitOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  double getAppBarHeight() {
    return kToolbarHeight;
  }

  double getKeyBoardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  bool isPhysicalDevice() {
    return Platform.isAndroid || Platform.isIOS;
  }

  void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  Future<void> setPreferredOrientation(List<DeviceOrientation> orientation) async {
    await SystemChrome.setPreferredOrientations(orientation);
  }

  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  bool isIOS() {
    return Platform.isIOS;
  }

  bool isAndroid() {
    return Platform.isAndroid;
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
