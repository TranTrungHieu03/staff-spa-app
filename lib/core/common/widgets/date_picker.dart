import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Hàm callback trả về ngày được chọn

  const DatePickerWidget({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Màu header và nút điều hướng
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Màu header
              onPrimary: Colors.white, // Màu chữ trong header
              surface: Colors.white, // Màu nền dialog
              onSurface: Colors.black, // Màu chữ trong body

            ),
            dialogBackgroundColor: Colors.white, // Màu nền tổng thể
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
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
              _selectedDate != null
                  ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                  : "Select a date",
              style: Theme.of(context)!.textTheme.bodyMedium,
            ),
            const SizedBox(
              width: TSizes.sm,
            ),
            Icon(Iconsax.calendar_1, color: TColors.primary),
          ],
        ),
      ),
    );
  }
}
