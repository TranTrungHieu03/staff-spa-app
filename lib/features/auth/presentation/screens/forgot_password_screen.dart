import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/styles/spacing_styles.dart';
import 'package:spa_mobile/core/common/widgets/loader.dart';
import 'package:spa_mobile/core/common/widgets/show_snackbar.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/core/utils/validators/validation.dart';
import 'package:spa_mobile/features/auth/domain/usecases/forget_password.dart';
import 'package:spa_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              goVerify(_emailController.text.toString(), 0);
            } else if (state is AuthFailure) {
              TSnackBar.errorSnackBar(context, message: state.message);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: TSpacingStyles.paddingWithAppbarHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.forgotPasswordTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.primary),
                      ),
                      const SizedBox(
                        height: TSizes.sm,
                      ),
                      Text(
                        AppLocalizations.of(context)!.forgotPasswordSub,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: TSizes.md,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) => TValidator.validateEmail(value),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.direct_right),
                            labelText: AppLocalizations.of(context)!.email,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.md,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                    ForgetPasswordEvent(
                                        params: ForgetPasswordParams(
                                            email: _emailController.text
                                                .toString())));
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.send)),
                      ),
                    ],
                  ),
                ),
                if (state is AuthLoading) const TLoader()
              ],
            );
          }),
        ));
  }
}
