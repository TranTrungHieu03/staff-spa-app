import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;
  final TimeOfDay initialTime;

  const TimePickerWidget({super.key, required this.onTimeSelected, required this.initialTime});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

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
              _selectedTime != null ? _selectedTime.format(context) : "Select time",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              width: TSizes.sm,
            ),
            const Icon(Iconsax.clock, color: TColors.primary),
          ],
        ),
      ),
    );
  }
}
