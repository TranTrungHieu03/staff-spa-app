import 'package:flutter/material.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';

class ShipmentInformationScreen extends StatefulWidget {
  const ShipmentInformationScreen({super.key});

  @override
  State<ShipmentInformationScreen> createState() =>
      _ShipmentInformationScreenState();
}

class _ShipmentInformationScreenState extends State<ShipmentInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          "Thông tin giao hàng",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
