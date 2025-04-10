import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/helpers/helper_functions.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:staff_app/features/appointment/presentation/widgets/scanner_overlay.dart';

class CheckInArrivedScreen extends StatefulWidget {
  const CheckInArrivedScreen({super.key});

  @override
  State<CheckInArrivedScreen> createState() => _CheckInArrivedScreenState();
}

class _CheckInArrivedScreenState extends State<CheckInArrivedScreen> with SingleTickerProviderStateMixin {
  final MobileScannerController cameraController = MobileScannerController();
  late AnimationController _animationController;
  late Animation<double> _scanLinePosition;
  bool isScanned = false;
  bool blocIsActive = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLinePosition = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    blocIsActive = false;
    super.dispose();
  }

  void _handleCode(BarcodeCapture barcode) {
    if (!isScanned && mounted) {
      final rawValue = barcode.raw[0]['displayValue'];
      if (rawValue != null) {
        try {
          final decoded = jsonDecode(rawValue);
          final id = decoded['id'];
          AppLogger.info('Scanned ID: $id');

          isScanned = true;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (!mounted || !blocIsActive) return;

            try {
              context.read<AppointmentBloc>().add(
                    CheckInEvent(CheckInParams(orderId: id)),
                  );
            } catch (e) {
              AppLogger.error('Failed to add event to Bloc: $e');
              isScanned = false;
            }
          });
        } catch (e) {
          AppLogger.error('Failed to parse QR code: $e');
          isScanned = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset(0, -THelperFunctions.screenHeight(context) * 0.2)),
      width: THelperFunctions.screenWidth(context) * 0.7,
      height: THelperFunctions.screenWidth(context) * 0.7,
    );

    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentError) {
          TSnackBar.errorSnackBar(context, message: state.message);
          isScanned = false;
        }
        if (state is AppointmentIdLoaded) {
          TSnackBar.successSnackBar(context, message: state.id);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const TAppbar(
            title: Text("QR Scanner"),
            showBackArrow: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Position the QR code within the frame to scan",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MobileScanner(
                      fit: BoxFit.contain,
                      controller: cameraController,
                      onDetect: _handleCode,
                      scanWindow: scanWindow,
                      errorBuilder: (context, error, child) => const SizedBox(),
                    ),
                    AnimatedBuilder(
                      animation: _scanLinePosition,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: ScannerOverlayPainter(
                            scanWindow,
                            scanLinePercent: _scanLinePosition.value,
                          ),
                        );
                      },
                    ),
                    if (state is AppointmentLoading) const TLoader()
                  ],
                ),
              ),
              const Expanded(
                flex: 3,
                child: Center(),
              ),
            ],
          ),
        );
      },
    );
  }
}
