import 'package:flutter/material.dart';
import 'package:spa_mobile/core/common/widgets/animation_loader.dart';

class TFullScreenLoader {
  static void openLoadingDialog(
      BuildContext context, String text, String animation) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Colors.transparent,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 250,
              ),
              TAnimationLoader(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
