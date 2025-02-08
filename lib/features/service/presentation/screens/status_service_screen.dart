import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class StatusServiceScreen extends StatefulWidget {
  const StatusServiceScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.value,
      required this.image,
      required this.color});

  final String title, content;
  final Widget value;
  final String image;
  final Color color;

  @override
  State<StatusServiceScreen> createState() => _StatusServiceScreenState();
}

class _StatusServiceScreenState extends State<StatusServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        actions: [
          TRoundedIcon(
            icon: Iconsax.home,
            color: TColors.primary,
            onPressed: () {
              goHome();
            },
          ),
          const SizedBox(
            width: TSizes.sm,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.sm),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TRoundedImage(imageUrl: widget.image),
              const SizedBox(
                height: TSizes.sm,
              ),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: widget.color),
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              Text(widget.content)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      goBookingDetail("1");
                    },
                    child: Text("View Detail")))
          ],
        ),
      ),
    );
  }
}
