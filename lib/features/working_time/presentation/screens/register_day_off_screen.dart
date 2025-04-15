import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/features/auth/data/models/staff_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_day_off.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_working_time.dart';
import 'package:staff_app/features/working_time/presentation/bloc/shift/shift_bloc.dart';
import 'package:staff_app/init_dependencies.dart';

class WrapperRegisterDayOff extends StatelessWidget {
  const WrapperRegisterDayOff({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShiftBloc(
        registerDayOff: serviceLocator<RegisterDayOff>(),
        registerWorkingTime: serviceLocator<RegisterWorkingTime>(),
      ),
      child: BlocListener<ShiftBloc, ShiftState>(
        listener: (context, state) {
          if (state is ShiftError) {
            TSnackBar.warningSnackBar(context, message: state.message);
          }
          if (state is ShiftSuccess) {
            TSnackBar.successSnackBar(context, message: state.message);
            goHome();
          }
        },
        child: RegisterDayOffScreen(selectedDate: selectedDate),
      ),
    );
  }
}

class RegisterDayOffScreen extends StatefulWidget {
  const RegisterDayOffScreen({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  State<RegisterDayOffScreen> createState() => _RegisterDayOffScreenState();
}

class _RegisterDayOffScreenState extends State<RegisterDayOffScreen> {
  final TextEditingController _reasonController = TextEditingController();

  StaffModel? staff;

  @override
  void initState() {
    super.initState();
    _loadStaffInfo();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _loadStaffInfo() async {
    final staffJson = await LocalStorage.getData(LocalStorageKey.staffInfo);
    if (staffJson != null) {
      setState(() {
        staff = StaffModel.fromJson(jsonDecode(staffJson));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký nghỉ 1 ngày'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Ngày nghỉ:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(DateFormat('EEEE, dd/MM/yyyy').format(widget.selectedDate), style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 24),
            const Text('Lý do nghỉ:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Nhập lý do nghỉ...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_reasonController.text.isEmpty) {
                    TSnackBar.warningSnackBar(context, message: "Vui lòng  nhập lý do");
                    return;
                  }

                  context.read<ShiftBloc>().add(
                        RegisterShiftOffEvent(
                          RegisterDayOffParams(
                            staffId: staff?.staffId ?? 0,
                            leaveDate: widget.selectedDate,
                            reason: _reasonController.text,
                          ),
                        ),
                      );

                  setState(() {
                    _reasonController.clear();
                  });
                },
                child: const Text('Gửi yêu cầu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
