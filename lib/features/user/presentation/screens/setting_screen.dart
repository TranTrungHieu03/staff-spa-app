import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/section_heading.dart';
import 'package:spa_mobile/core/provider/language_provider.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/user/presentation/widgets/setting_menu_title.dart';
import 'package:spa_mobile/features/user/presentation/widgets/user_profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
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
                  TSectionHeading(
                    title: AppLocalizations.of(context)!.account_settings,
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.award,
                    title: AppLocalizations.of(context)!.rewards,
                    onTap: () {},
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  TSettingsMenuTile(
                    icon: Icons.language_outlined,
                    title: AppLocalizations.of(context)!.language,
                    onTap: () {
                      _changeLanguagePopup(context);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          languageProvider.getLanguageName(
                              languageProvider.locale.languageCode),
                          style: Theme.of(context).textTheme.bodySmall,
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
                    onTap: () => goHistory(),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bookmark,
                    title: AppLocalizations.of(context)!.appointment,
                    onTap: () => goServiceHistory(),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  const Divider(),
                  TSettingsMenuTile(
                    icon: Iconsax.profile_remove,
                    title: AppLocalizations.of(context)!.delete_account,
                    onTap: () => _deleteAccountWarningPopup(context),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.logout,
                    title: AppLocalizations.of(context)!.logout,
                    onTap: () {
                      goLoginNotBack();
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

  void _changeLanguagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Language'),
          content:
              const Text('Are you sure you want to change to Vietnamese? '),
          actions: [
            TextButton(
              onPressed: () async {
                await Provider.of<LanguageProvider>(context, listen: false)
                    .changeLanguage(Locale('vi'));
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
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
