import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:staff_app/core/common/widgets/rounded_container.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

Widget chatTypeMessageWidget(TextEditingController messageTextController, Function submitMessageFunction, VoidCallback onTapMessage) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: 60,
      maxHeight: 120.0,
    ),
    child: TRoundedContainer(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 60,
                  maxHeight: 120.0,
                ),
                child: TextField(
                  controller: messageTextController,
                  scrollPhysics: BouncingScrollPhysics(),
                  maxLines: null,
                  onTap: () => onTapMessage(),
                  style: TextStyle(color: TColors.gradientColorFrom),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    filled: false,
                    focusedBorder: InputBorder.none,
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: TColors.gradientColorTo.withOpacity(.4),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(16, 16, 32, 16),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => submitMessageFunction(),
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Iconsax.send_1,
                color: TColors.gradientColorFrom,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
