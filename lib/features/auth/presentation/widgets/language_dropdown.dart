import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/provider/language_provider.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/images.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = LanguageProvider().getCurrentLanguageCode();

  final Map<String, String> languages = {
    'en': TImages.english,
    'vi': TImages.vietnam,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          selectedLanguage = value;
          AppLogger.info(selectedLanguage);
        });
        _handleLanguageChange(value);
      },
      itemBuilder: (BuildContext context) {
        return languages.keys.map<PopupMenuEntry<String>>((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Image.asset(
                  languages[value]!,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: TSizes.sm),
                Text(
                  value == 'en' ? AppLocalizations.of(context)!.english : AppLocalizations.of(context)!.vietnamese,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }).toList();
      },
      color: TColors.primaryBackground,
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          color: TColors.primaryBackground.withOpacity(0.5),
          borderRadius: BorderRadius.circular(TSizes.md),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              languages[selectedLanguage]!,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: TSizes.sm),
            const Icon(
              Iconsax.arrow_down_1,
              color: TColors.black,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _handleLanguageChange(String language) async {
    await Provider.of<LanguageProvider>(context, listen: false).changeLanguage(Locale(language));
  }
}
