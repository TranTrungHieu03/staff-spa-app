import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/auth/data/models/staff_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_working_time.dart';
import 'package:staff_app/features/working_time/presentation/bloc/list_shift/list_shift_bloc.dart';
import 'package:staff_app/features/working_time/presentation/bloc/shift/shift_bloc.dart';
import 'package:staff_app/init_dependencies.dart';
import 'package:table_calendar/table_calendar.dart';

class WrapperRegisterScreen extends StatelessWidget {
  const WrapperRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ListShiftBloc>(
        create: (_) => ListShiftBloc(getShifts: serviceLocator())..add(GetListShiftEvent()),
      ),
      BlocProvider<ShiftBloc>(
        create: (_) => ShiftBloc(registerWorkingTime: serviceLocator(), registerDayOff: serviceLocator()),
      ),
    ], child: RegisterWorkingSlotScreen());
  }
}

class RegisterWorkingSlotScreen extends StatefulWidget {
  const RegisterWorkingSlotScreen({super.key});

  @override
  State<RegisterWorkingSlotScreen> createState() => _RegisterWorkingSlotScreenState();
}

class _RegisterWorkingSlotScreenState extends State<RegisterWorkingSlotScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  StaffModel? staff;
  Map<DateTime, Set<int>> selectedShifts = {};

  @override
  void initState() {
    super.initState();
    _loadStaffInfo();
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1);
    _focusedDay = nextMonth;
    _selectedDay = nextMonth;
  }

  void _loadStaffInfo() async {
    final staffJson = await LocalStorage.getData(LocalStorageKey.staffInfo);
    if (staffJson != null) {
      setState(() {
        staff = StaffModel.fromJson(jsonDecode(staffJson));
      });
    }
  }

  void _toggleShift(DateTime date, int shift) {
    final year = date.year;
    final month = date.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);

    setState(() {
      for (int day = 1; day <= daysInMonth; day++) {
        final currentDate = DateTime(year, month, day);
        selectedShifts[currentDate] ??= {};

        if (selectedShifts[currentDate]!.contains(shift)) {
          selectedShifts[currentDate]!.remove(shift);
          if (selectedShifts[currentDate]!.isEmpty) {
            selectedShifts.remove(currentDate);
          }
        } else {
          selectedShifts[currentDate]!.add(shift);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng ký ca làm việc")),
      body: BlocListener<ShiftBloc, ShiftState>(
          listener: (context, state) {
            if (state is ShiftError) {
              TSnackBar.errorSnackBar(context, message: state.message);
            } else if (state is ShiftSuccess) {
              TSnackBar.successSnackBar(context, message: state.message);
              goHome();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 12),
                    TableCalendar(
                      locale: 'vi',
                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2030),
                      focusedDay: _focusedDay,
                      headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: false),
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, _) {
                        final now = DateTime.now();
                        final nextMonthStart = DateTime(now.year, now.month + 1);
                        if (selectedDay.isBefore(nextMonthStart)) {
                          TSnackBar.warningSnackBar(context, message: "Chỉ được đăng ký từ tháng sau trở đi");
                          return;
                        }

                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onPageChanged: (focusedDay) {
                        final now = DateTime.now();
                        final nextMonthStart = DateTime(now.year, now.month + 1);

                        if (focusedDay.isBefore(DateTime(nextMonthStart.year, nextMonthStart.month))) {
                          TSnackBar.warningSnackBar(context, message: "Chỉ được đăng ký từ tháng sau trở đi");
                          return;
                        }

                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          if (day.month == _focusedDay.month) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: TColors.primaryBackground,
                                shape: BoxShape.circle,
                              ),
                              margin: const EdgeInsets.all(6),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }
                          return null;
                        },
                        markerBuilder: (context, date, _) {
                          final key = DateTime(date.year, date.month, date.day);
                          if (selectedShifts.containsKey(key)) {
                            return Positioned(
                              bottom: 1,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${selectedShifts[key]!.length}",
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    const SizedBox(height: TSizes.spacebtwSections),
                    Text("Chọn ca cho tháng ${_selectedDay.month}", style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    BlocBuilder<ListShiftBloc, ListShiftState>(
                      builder: (_, state) {
                        if (state is ListShiftLoaded) {
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: state.shifts.map((shift) {
                              final isSelected =
                                  selectedShifts[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)]?.contains(shift.id) ??
                                      false;
                              return ChoiceChip(
                                label: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      shift.name,
                                      style:
                                          Theme.of(context).textTheme.bodyMedium!.copyWith(color: isSelected ? Colors.white : Colors.black),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          shift.startTime.substring(0, 5),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 15,
                                          color: isSelected ? TColors.white : TColors.black,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          shift.endTime.substring(0, 5),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.grey[200],
                                selected: isSelected,
                                onSelected: (_) => _toggleShift(_selectedDay, shift.id),
                                selectedColor: Colors.blueAccent,
                                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                              );
                            }).toList(),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedShifts[DateTime(_selectedDay.year, _selectedDay.month, 1)]?.isEmpty ?? true) {
                          TSnackBar.warningSnackBar(context, message: "Vui lòng chọn ca làm việc");
                          return;
                        }
                        print('Dữ liệu đã chọn: ${selectedShifts[DateTime(_selectedDay.year, _selectedDay.month, 1)]?.toList()}');
                        context.read<ShiftBloc>().add(
                              RegisterShiftEvent(
                                RegisterWorkingTimeParams(
                                    staffId: staff?.staffId.toString() ?? '',
                                    fromDate: DateTime(_selectedDay.year, _selectedDay.month, 1),
                                    toDate: DateTime(_selectedDay.year, _selectedDay.month + 1, 0),
                                    shiftIds: selectedShifts[DateTime(_selectedDay.year, _selectedDay.month, 1)]?.toList() ?? []),
                              ),
                            );
                      },
                      child: Text(
                        "Lưu đăng ký",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<ShiftBloc, ShiftState>(
                  builder: (context, state) {
                    if (state is ShiftLoading) return const TLoader();
                    return const SizedBox.shrink();
                  },
                ),
                BlocBuilder<ListShiftBloc, ListShiftState>(
                  builder: (context, state) {
                    if (state is ListShiftLoading) return const TLoader();
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          )),
    );
  }
}
