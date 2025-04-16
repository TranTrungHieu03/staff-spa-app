import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/rounded_container.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/appointment/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:staff_app/features/appointment/presentation/bloc/image/image_bloc.dart';
import 'package:staff_app/init_dependencies.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  State<AppointmentDetailScreen> createState() => _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  String lgCode = 'vi';

  Future<void> _loadLanguageAndInit() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lgCode = prefs.getString('language_code') ?? "vi";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLanguageAndInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Appointment Detail'),
        showBackArrow: true,
      ),
      body: BlocProvider(
        create: (_) =>
            AppointmentBloc(getAppointment: serviceLocator(), checkIn: serviceLocator())..add(GetAppointmentEvent(widget.appointmentId)),
        child: BlocBuilder<AppointmentBloc, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AppointmentLoaded) {
              final appointment = state.appointment;
              return Padding(
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.calendar_1,
                          color: TColors.primary,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Text(
                          appointment.status,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.building,
                          color: TColors.primary,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.branch?.branchName ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              appointment.branch?.branchAddress ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.calendar_1,
                          color: TColors.primary,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy', lgCode).format(appointment.appointmentsTime).toString(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.clock,
                          color: TColors.primary,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Text(
                          "${DateFormat('HH:mm', lgCode).format(appointment.appointmentsTime).toString()} - "
                          "${DateFormat('HH:mm', lgCode).format(appointment.appointmentEndTime).toString()}",
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    TRoundedContainer(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer information', style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
                          const SizedBox(
                            height: TSizes.sm,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.user,
                                size: 17,
                              ),
                              const SizedBox(
                                width: TSizes.sm,
                              ),
                              Text(
                                appointment.customer?.fullName ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.call,
                                size: 17,
                              ),
                              const SizedBox(
                                width: TSizes.sm,
                              ),
                              Text(
                                appointment.customer?.phoneNumber ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    TRoundedContainer(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Service information', style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
                          const SizedBox(
                            height: TSizes.sm,
                          ),
                          Text(
                            appointment.service.name ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              Text('Duration:'),
                              const SizedBox(
                                width: TSizes.sm,
                              ),
                              Text(
                                '${appointment.service.duration} minutes' ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Text(
                            appointment.service.description ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: TSizes.sm,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Steps: '),
                              const SizedBox(
                                width: TSizes.sm,
                              ),
                              Text(
                                '${appointment.service.steps} ' ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    TRoundedContainer(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tracking information', style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Before image:'),
                              SizedBox(
                                width: TSizes.sm,
                              ),
                              Text('After image')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    context.read<ImageBloc>().add(PickImageEvent(true));
                                  },
                                  child: Text('Take')),
                              TextButton(
                                  onPressed: () {
                                    context.read<ImageBloc>().add(PickImageEvent(true));
                                  },
                                  child: Text('Take')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.md,
                    ),
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: Text('Completed confirm'))),
                  ])));
            } else if (state is AppointmentError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
