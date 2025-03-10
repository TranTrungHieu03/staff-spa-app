import 'package:flutter/material.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: TAppbar(
          showBackArrow: true,
        ),
        body: TErrorBody());
  }
}

class TErrorBody extends StatelessWidget {
  const TErrorBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Please come back later.'),
          ),
          TextButton(
            onPressed: () {
              goHome();
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}
