import 'package:flutter/material.dart';
import 'package:spa_mobile/features/service/presentation/widgets/service_vertical_card.dart';

class TRelatedService extends StatelessWidget {
  const TRelatedService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 260,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(6, (index) {
            return Padding(
                padding: const EdgeInsets.all(8.0), child: TServiceCard());
          }),
        ));
  }
}
