import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/provider/language_provider.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:staff_app/features/user/presentation/widgets/setting_menu_title.dart';
import 'package:staff_app/features/user/presentation/widgets/user_profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final userJson = await LocalStorage.getData(LocalStorageKey.userKey);
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
    final languageProvider = Provider.of<LanguageProvider>(context);
    final code = languageProvider.getCurrentLanguageCode();
    String languageChange;
    if (code == 'vi') {
      languageChange = 'en';
    } else {
      languageChange = 'vi';
    }
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          AppLocalizations.of(context)!.account,
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TUserProfileTile(
              userData: user,
              onPressed: () => goProfile(),
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
              child: Column(
                children: [
                  // TSettingsMenuTile(
                  //   icon: Iconsax.award,
                  //   title: AppLocalizations.of(context)!.rewards,
                  //   onTap: () {},
                  //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  // ),
                  TSettingsMenuTile(
                    icon: Icons.language_outlined,
                    title: AppLocalizations.of(context)!.language,
                    onTap: () {
                      _changeLanguagePopup(context, languageChange);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          languageProvider.getLanguageName(languageProvider.locale.languageCode),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.receipt,
                    title: AppLocalizations.of(context)!.order_name,
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bookmark,
                    title: 'Goi lieu trinh',
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  const Divider(),
                  TSettingsMenuTile(
                    icon: Iconsax.profile_remove,
                    title: AppLocalizations.of(context)!.delete_account,
                    onTap: () => _deleteAccountWarningPopup(context),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthClear) {
                        goLoginNotBack();
                      }
                    },
                    builder: (context, state) {
                      return ListTile(
                        leading: const Icon(
                          Iconsax.logout,
                          size: 24,
                          color: TColors.black,
                        ),
                        title: Text(AppLocalizations.of(context)!.logout, style: Theme.of(context).textTheme.titleMedium),
                        trailing: null,
                        onTap: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteAccountWarningPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account permanently? '
            'This action is not reversible and all of your data will be removed permanently.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Delete'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguagePopup(BuildContext context, String languageChange) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Change Language'),
          content: Text(
              'Are you sure you want to change to ${Provider.of<LanguageProvider>(context, listen: false).getLanguageName(languageChange)}? '),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<LanguageProvider>(context, listen: false).changeLanguage(Locale(languageChange));
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Change'),
              ),
            ),
          ],
        );
      },
    );
  }
}
