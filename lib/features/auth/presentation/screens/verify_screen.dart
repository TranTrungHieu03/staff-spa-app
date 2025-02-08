import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spa_mobile/core/common/widgets/loader.dart';
import 'package:spa_mobile/core/common/widgets/otp_field.dart';
import 'package:spa_mobile/core/common/widgets/show_snackbar.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/auth/domain/usecases/verify_otp.dart';
import 'package:spa_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    super.key,
    required this.email,
    required this.statePage,
  });

  final String email;
  final int statePage;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _pin1Controller = TextEditingController();
  final _pin2Controller = TextEditingController();
  final _pin3Controller = TextEditingController();
  final _pin4Controller = TextEditingController();
  final _pin5Controller = TextEditingController();
  final _pin6Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String mergeOTP(String box1, String box2, String box3, String box4,
      String box5, String box6) {
    return "${box1.toString().trim()}${box2.toString().trim()}${box3.toString().trim()}${box4.toString().trim()}${box5.toString().trim()}${box6.toString().trim()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          if (widget.statePage == 1) {
            goSuccess(AppLocalizations.of(context)!.signUpSuccess,
                AppLocalizations.of(context)!.signUpSuccessSub, () {
              goLoginNotBack();
            }, TImages.success);
          } else {
            goSetPassword(widget.email);
          }
        } else if (state is AuthFailure) {
          TSnackBar.errorSnackBar(context, message: state.message);
        }
      }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.verifyTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: TSizes.spacebtwItems,
                    ),
                    Text(
                      widget.email ?? "",
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: TSizes.spacebtwItems,
                    ),
                    Text(
                      AppLocalizations.of(context)!.verifySubTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: TSizes.spacebtwSections,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: OTPFields(
                        keyForm: _formKey,
                        pin1: _pin1Controller,
                        pin2: _pin2Controller,
                        pin3: _pin3Controller,
                        pin4: _pin4Controller,
                        pin5: _pin5Controller,
                        pin6: _pin6Controller,
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spacebtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_pin1Controller.text.isNotEmpty &&
                                _pin2Controller.text.isNotEmpty &&
                                _pin3Controller.text.isNotEmpty &&
                                _pin4Controller.text.isNotEmpty &&
                                _pin5Controller.text.isNotEmpty &&
                                _pin6Controller.text.isNotEmpty) {
                              context.read<AuthBloc>().add(VerifyEvent(
                                  params: VerifyOtpParams(
                                      email: widget.email,
                                      otp: mergeOTP(
                                          _pin1Controller.text.toString(),
                                          _pin2Controller.text.toString(),
                                          _pin3Controller.text.toString(),
                                          _pin4Controller.text.toString(),
                                          _pin5Controller.text.toString(),
                                          _pin6Controller.text.toString()))));
                            } else {
                              TSnackBar.warningSnackBar(context,
                                  message: "Enter enough 6 digits to continue");
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.verify)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                          onPressed: () => {},
                          child: Text(AppLocalizations.of(context)!.resend))
                    ])
                  ],
                ),
              ),
            ),
            if (state is AuthLoading) const TLoader()
          ],
        );
      })),
    );
  }
}
