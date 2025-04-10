import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';

class WorkScheduleScreen extends StatefulWidget {
  const WorkScheduleScreen({super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleScreenState();
}

class _WorkScheduleScreenState extends State<WorkScheduleScreen> {
  late DateTime _selectedDate;
  late List<DateTime> _eventDates;
  late String _lgCode = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguageAndInit();
    _resetSelectedDate();
  }

  Future<void> _loadLanguageAndInit() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lgCode = prefs.getString('language_code') ?? "vi";
    });
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
    _eventDates = [
      DateTime.now().add(const Duration(days: 2)),
      DateTime.now().add(const Duration(days: 3)),
      DateTime.now().add(const Duration(days: 4)),
      DateTime.now().subtract(const Duration(days: 4)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: false,
        title: Text("Work Schedule"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Column(
          children: [
            CalendarTimeline(
              showYears: true,
              initialDate: _selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 30 * 2)),
              lastDate: DateTime.now().add(const Duration(days: 30 * 3)),
              eventDates: _eventDates,
              onDateSelected: (date) => setState(() => _selectedDate = date),
              leftMargin: TSizes.sm,
              monthColor: TColors.black,
              dayColor: TColors.black,
              dayNameColor: TColors.white,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: TColors.primary,
              dotColor: TColors.secondary,
              // selectableDayPredicate: (date) => date.day != 23,
              locale: _lgCode,
            ),

          ],
        ),
      ),
    );
  }
}
