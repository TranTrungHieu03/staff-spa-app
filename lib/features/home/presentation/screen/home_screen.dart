import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/common/widgets/rounded_container.dart';
import 'package:staff_app/core/common/widgets/rounded_icon.dart';
import 'package:staff_app/core/common/widgets/shimmer.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/helpers/helper_functions.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/working_time/data/model/staff_shift_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/get_working_time.dart';
import 'package:staff_app/features/working_time/presentation/bloc/woking_time/working_time_bloc.dart';
import 'package:staff_app/init_dependencies.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
    _loadLanguage();
  }

  void _getUser() async {
    final userJson = await LocalStorage.getData(LocalStorageKey.userKey);
    AppLogger.info("User: $userJson");
    if (jsonDecode(userJson) != null) {
      setState(() {
        user = UserModel.fromJson(jsonDecode(userJson));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      goLoginNotBack();
    }
  }

  DateTime _selectedDate = DateTime.now();
  String _lgCode = 'vi';

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lgCode = prefs.getString('language_code') ?? "vi";
    });
  }

  DateTime getStartOfWeek(DateTime date) {
    DateTime monday = date.subtract(Duration(days: date.weekday - DateTime.monday));
    return DateTime(monday.year, monday.month, monday.day, 0, 0, 0);
  }

  DateTime getEndOfWeek(DateTime date) {
    final end = date.add(Duration(days: DateTime.sunday - date.weekday));
    return DateTime(end.year, end.month, end.day, 23, 59, 59, 999);
  }

  Map<DateTime, List<StaffShiftModel>> _groupByDay(List<StaffShiftModel> list) {
    final Map<DateTime, List<StaffShiftModel>> grouped = {};
    for (var shift in list) {
      final key = DateTime(shift.workDate.year, shift.workDate.month, shift.workDate.day);
      grouped.putIfAbsent(key, () => []).add(shift);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: false,
        title: isLoading
            ? const TShimmerEffect(width: TSizes.shimmerLg, height: TSizes.shimmerSm)
            : Text(
                "Hey, ${user?.fullName}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ),
      body: BlocProvider(
        create: (_) => WorkingTimeBloc(getWorkingTime: serviceLocator())
          ..add(GetWorkingTimeEvent(
            GetWorkingTimeParams(fromDate: getStartOfWeek(_selectedDate), toDate: getEndOfWeek(_selectedDate)),
          )),
        child: BlocConsumer<WorkingTimeBloc, WorkingTimeState>(
          listener: (context, state) {
            if (state is WorkingTimeError) {
              TSnackBar.errorSnackBar(context, message: state.message);
            }
          },
          builder: (context, state) {
            final events = state is WorkingTimeLoaded ? _groupByDay(state.shifts) : {};
            final selectedEvents = events[DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)] ?? [];

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => goRegisterShift(),
                        child: TRoundedContainer(
                          child: Padding(
                            padding: const EdgeInsets.only(right: TSizes.md),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TRoundedIcon(
                                  icon: Iconsax.key,
                                  color: TColors.primary,
                                ),
                                Text(
                                  "Register shift",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TableCalendar<StaffShiftModel>(
                        locale: _lgCode,
                        firstDay: DateTime.utc(2020),
                        lastDay: DateTime.utc(2030),
                        focusedDay: _selectedDate,
                        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                        onDaySelected: (selectedDay, _) {
                          final oldWeekStart = getStartOfWeek(_selectedDate);
                          final newWeekStart = getStartOfWeek(selectedDay);

                          setState(() => _selectedDate = selectedDay);

                          if (!isSameDay(oldWeekStart, newWeekStart)) {
                            context.read<WorkingTimeBloc>().add(GetWorkingTimeEvent(
                                  GetWorkingTimeParams(fromDate: getStartOfWeek(_selectedDate), toDate: getEndOfWeek(_selectedDate)),
                                ));
                          }
                        },
                        onPageChanged: (focusedDay) {
                          final oldWeekStart = getStartOfWeek(_selectedDate);
                          final newWeekStart = getStartOfWeek(focusedDay);

                          // Cập nhật _selectedDate để theo dõi tuần hiện tại
                          setState(() {
                            _selectedDate = focusedDay;
                          });

                          if (!isSameDay(oldWeekStart, newWeekStart)) {
                            context.read<WorkingTimeBloc>().add(GetWorkingTimeEvent(
                                  GetWorkingTimeParams(fromDate: getStartOfWeek(_selectedDate), toDate: getEndOfWeek(_selectedDate)),
                                ));
                          }
                        },
                        eventLoader: (day) {
                          return events[DateTime(day.year, day.month, day.day)] ?? [];
                        },
                        calendarFormat: CalendarFormat.week,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        rowHeight: 52,
                        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: false),
                        calendarStyle: const CalendarStyle(
                          todayDecoration: BoxDecoration(color: TColors.primary, shape: BoxShape.circle),
                          selectedDecoration: BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                        ),
                        calendarBuilders: CalendarBuilders(
                          dowBuilder: (context, day) {
                            final text = DateFormat.E(_lgCode).format(day);
                            return Center(
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.montserrat().fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: day.weekday == DateTime.sunday ? Colors.red : Colors.black87,
                                ),
                              ),
                            );
                          },
                          markerBuilder: (context, date, shifts) {
                            if (shifts.isNotEmpty) {
                              return Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: TColors.primary,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      const SizedBox(height: TSizes.lg),
                      if (state is WorkingTimeLoaded && selectedEvents.isEmpty)
                        const Expanded(
                          child: const Center(
                            child: Text(
                              "No slot working available",
                              style: TextStyle(fontSize: 16, color: TColors.black),
                            ),
                          ),
                        ),
                      if (state is WorkingTimeLoaded)
                        Expanded(
                          child: ListView.separated(
                            itemCount: selectedEvents.length,
                            separatorBuilder: (_, __) => const SizedBox(height: TSizes.sm),
                            itemBuilder: (context, index) {
                              final StaffShiftModel shift = selectedEvents[index];
                              return TRoundedContainer(
                                backgroundColor: (shift.status.toLowerCase()) == 'active'
                                    ? TColors.primaryBackground
                                    : shift.status.toLowerCase() == 'cancelled'
                                        ? TColors.error
                                        : TColors.primaryBackground,
                                padding: EdgeInsets.all(TSizes.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shift.shift.name,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: TSizes.sm),
                                    Row(
                                      children: [
                                        const Icon(
                                          Iconsax.clock,
                                          size: 20,
                                        ),
                                        const SizedBox(width: TSizes.sm),
                                        Text(
                                          "${shift.shift.startTime.substring(0, 5)} - "
                                          "${shift.shift.endTime.substring(0, 5)}",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: TSizes.sm),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      if (state is WorkingTimeLoaded && selectedEvents.isNotEmpty)
                        TextButton(
                            onPressed: () => goRegisterDayOff(_selectedDate),
                            child: Text(
                              'Register day off',
                              style: Theme.of(context)!.textTheme.bodyMedium,
                            )),
                    ],
                  ),
                ),
                if (state is WorkingTimeLoading) const TLoader(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TFlashAction extends StatelessWidget {
  const TFlashAction({
    super.key,
    required this.title,
    required this.iconData,
    required this.onPressed,
  });

  final String title;
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: THelperFunctions.screenWidth(context) * 0.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TRoundedIcon(
                icon: iconData,
                color: TColors.primary,
                backgroundColor: TColors.primaryBackground,
                borderRadius: TSizes.sm,
              ),
              const SizedBox(
                height: TSizes.sm / 2,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
