import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/date_picker.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/common/widgets/time_picker.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/screens/checkout_screen.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

// cho nhap dia chi xong rcm branch gan do va km
class CheckoutServiceScreen extends StatefulWidget {
  const CheckoutServiceScreen({super.key});

  @override
  State<CheckoutServiceScreen> createState() => _CheckoutServiceScreenState();
}

class _CheckoutServiceScreenState extends State<CheckoutServiceScreen> {
  @override
  Widget build(BuildContext context) {
    String? _selectedValue;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.sm),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TRoundedIcon(icon: Iconsax.location),
                  Text(
                    "Update my location",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                "Branch Address",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: THelperFunctions.screenWidth(context),
                ),
                child: Row(
                  children: [
                    Expanded(
                      // Giới hạn không gian để mũi tên không tràn
                      child: DropdownButtonFormField<String>(
                        value: _selectedValue,
                        isDense: true,
                        dropdownColor: TColors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                        ),
                        items: [
                          "147 Hoang Huu Nam Tan Phu Thu Duc (5km)",
                          "123 Le Thi Rieng, District 1 (7km)",
                          "456 Nguyen Thi Minh Khai, District 3 (9km)",
                        ].map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                              value: item,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        THelperFunctions.screenWidth(context) *
                                            0.7),
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          _selectedValue = newValue;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              Text(
                AppLocalizations.of(context)!.service,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TRoundedContainer(
                shadow: true,
                padding: EdgeInsets.all(TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TRoundedImage(
                          applyImageRadius: true,
                          imageUrl: TImages.thumbnailService,
                          isNetworkImage: true,
                          width: THelperFunctions.screenWidth(context) * 0.2,
                          height: THelperFunctions.screenWidth(context) * 0.2,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  THelperFunctions.screenWidth(context) * 0.4),
                          child: TProductTitleText(
                            title: "Service Name 1",
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                    Text("30 mins"),
                    Text("6-step process. Includes 10-min massage"),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Day",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      DatePickerWidget(
                        onDateSelected: (selectedDate) {
                          print(
                              "Ngày đã chọn: ${selectedDate.toIso8601String()}");
                        },
                      ),
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Time",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TimePickerWidget(
                          onTimeSelected: (selectedTime) {
                            print("Ngày đã chọn: ${selectedTime}");
                          },
                        ),
                      ])
                ],
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              Text(
                "Payment Methods",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  Icon(
                    Iconsax.wallet,
                    color: TColors.primary,
                  ),
                  const SizedBox(
                    width: TSizes.sm,
                  ),
                  Text(AppLocalizations.of(context)!.bank_transfer,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  TRoundedIcon(
                    icon: Iconsax.tick_circle,
                    color: TColors.primary,
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              Text(
                "Promo Code",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                  onTap: () {
                    _showVoucherModal(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.select_or_enter_code,
                          style: Theme.of(context).textTheme.bodySmall),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  )),
              const SizedBox(
                height: TSizes.md,
              ),
              TPaymentDetail(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TBottomCheckout(),
    );
  }

  void _showVoucherModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: TSizes.md,
            right: TSizes.md,
            top: TSizes.md,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.shop_voucher,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your voucher code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Available Vouchers",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildVoucherItem(context, index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVoucherItem(BuildContext context, int index) {
    final voucherTitles = [
      "10% Off for First Order",
      "Free Shipping on Orders Over \$50",
      "Buy 2 Get 1 Free",
      "Buy 3 Get 1 Free",
      "Buy 5 Get 2 Free",
    ];
    final voucherCodes = [
      "FIRST10",
      "FREE_SHIP50",
      "B2G1FREE",
      "B3G1FREE",
      "B5G2FREE"
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.local_offer,
          color: Colors.green,
        ),
        title: Text(voucherTitles[index]),
        subtitle: Text("Code: ${voucherCodes[index]}"),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.md, vertical: 10),
          ),
          child: Text(
            AppLocalizations.of(context)!.apply,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontSize: TSizes.md,
                ),
          ),
        ),
      ),
    );
  }
}
