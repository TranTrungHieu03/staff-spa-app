import 'package:flutter/material.dart';
import 'package:staff_app/core/common/widgets/rounded_icon.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';

class TProfileItem extends StatelessWidget {
  const TProfileItem({super.key, required this.label, required this.icon, required this.controller});

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
