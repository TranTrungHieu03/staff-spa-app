import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/formatters/formatters.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = '\₫',
    required this.price,
    this.maxLine = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLine;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + formatMoney(price+"000"),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.bodyMedium!.apply(
          decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
          decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
