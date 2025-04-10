import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/shimmer.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final userJson = await LocalStorage.getData(LocalStorageKey.userKey);
    AppLogger.info("User: $userJson");
    if (jsonDecode(userJson) != null) {
      setState(() {
        user = UserModel.fromJson(jsonDecode(userJson));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      goLoginNotBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: false,
        title: isLoading
            ? const TShimmerEffect(width: TSizes.shimmerLg, height: TSizes.shimmerSm)
            : Text(
                "Hey, ${user?.fullName}",
                style: Theme.of(context).textTheme.displaySmall,
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Column(
          children: [
            // Text("Current appointment", style: Theme.of(context).textTheme.titleLarge),
            // ElevatedButton(onPressed: () => {}, child: Text("Đăng kí ca làm"))
          ],
        ),
      ),
    );
  }
}
