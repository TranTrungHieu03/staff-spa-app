import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/circular_image.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController fullNameController =
      TextEditingController(text: "Tran Trung Hieu");
  final TextEditingController emailController =
      TextEditingController(text: "hieuttjob@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "0834938483");
  final TextEditingController cityController =
      TextEditingController(text: "Ho Chi Minh");
  final TextEditingController userNameController =
      TextEditingController(text: "Hieutt");
  final TextEditingController addressController = TextEditingController(
      text: "174 Hoang Huu Nam ABC Cake Thu Duc Thanh Pho Ho Chi Minh");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          "Your Profile",
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(
                      image: TImages.avatar,
                      width: 80.0,
                      height: 80.0,
                      padding: TSizes.sm,
                    ),
                    TextButton(
                        onPressed: () => {},
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),
              TProfileItem(
                  label: "Full Name",
                  icon: Iconsax.profile_2user,
                  controller: fullNameController),
              const SizedBox(
                height: TSizes.sm,
              ),
              TProfileItem(
                  label: AppLocalizations.of(context)!.username,
                  icon: Iconsax.profile_2user,
                  controller: userNameController),
              const SizedBox(
                height: TSizes.sm,
              ),
              TProfileItem(
                  label: AppLocalizations.of(context)!.email,
                  icon: Iconsax.direct_right,
                  controller: emailController),
              const SizedBox(
                height: TSizes.sm,
              ),
              TProfileItem(
                  label: AppLocalizations.of(context)!.phone,
                  icon: Iconsax.call,
                  controller: phoneController),
              const SizedBox(
                height: TSizes.sm,
              ),
              TProfileItem(
                  label: "City",
                  icon: Iconsax.building,
                  controller: cityController),
              const SizedBox(
                height: TSizes.sm,
              ),
              TProfileItem(
                  label: "Address",
                  icon: Iconsax.home,
                  controller: addressController),
              const SizedBox(
                height: TSizes.md,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.md, vertical: 10),
                      side: const BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  )),
                  const SizedBox(
                    width: TSizes.md,
                  ),
                  GestureDetector(
                      child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.md, vertical: 10),
                    ),
                    child: Text(
                      "Save",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TProfileItem extends StatelessWidget {
  const TProfileItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.controller});

  final String label;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: TSizes.sm / 2,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.md),
            prefixIcon: TRoundedIcon(icon: icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
