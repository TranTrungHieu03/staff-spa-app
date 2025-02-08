import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay)
      onTimeSelected; // Hàm callback trả về thời gian được chọn

  const TimePickerWidget({Key? key, required this.onTimeSelected})
      : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.green, // Màu header và nút điều hướng
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              brightness: Brightness.light,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
      widget.onTimeSelected(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTime != null
                  ? "${_selectedTime!.format(context)}"
                  : "Select time",
              style: Theme.of(context)!.textTheme.bodyMedium,
            ),
            const SizedBox(
              width: TSizes.sm,
            ),
            Icon(Iconsax.clock, color: TColors.primary),
          ],
        ),
      ),
    );
  }
}
