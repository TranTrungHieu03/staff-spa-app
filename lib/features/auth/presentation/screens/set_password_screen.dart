import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/styles/spacing_styles.dart';
import 'package:spa_mobile/core/common/widgets/loader.dart';
import 'package:spa_mobile/core/common/widgets/show_snackbar.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/core/utils/validators/validation.dart';
import 'package:spa_mobile/features/auth/domain/usecases/reset_password.dart';
import 'package:spa_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_confirm_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_match_cubit.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          goSuccess(AppLocalizations.of(context)!.successSetPass,
              AppLocalizations.of(context)!.successSetPassSub, () {
            goLoginNotBack();
          }, TImages.success);
        } else if (state is AuthFailure) {
          TSnackBar.errorSnackBar(context, message: state.message);
        }
      }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: TSpacingStyles.paddingWithAppbarHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.setPassword,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.primary),
                  ),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Text(
                    AppLocalizations.of(context)!.setPasswordSub,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.md,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BlocBuilder<PasswordCubit, PasswordState>(
                            builder: (context, state) {
                              bool isPasswordHidden = true;

                              if (state is PasswordInitial) {
                                isPasswordHidden = state.isPasswordHidden;
                              } else if (state is PasswordVisibilityToggled) {
                                isPasswordHidden = state.isPasswordHidden;
                              }

                              return TextFormField(
                                controller: _passwordController,
                                obscureText: isPasswordHidden,
                                validator: (value) =>
                                    TValidator.validatePassword(value),
                                onChanged: (value) {
                                  context
                                      .read<PasswordMatchCubit>()
                                      .updatePassword(value);
                                },
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.password,
                                  prefixIcon:
                                      const Icon(Iconsax.password_check),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordHidden
                                          ? Iconsax.eye_slash
                                          : Iconsax.eye,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<PasswordCubit>()
                                          .togglePasswordVisibility();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: TSizes.sm,
                          ),
                          BlocBuilder<PasswordConfirmCubit,
                              PasswordConfirmState>(
                            builder: (context, state) {
                              bool isPasswordHidden = true;

                              if (state is PasswordConfirmInitial) {
                                isPasswordHidden = state.isHide;
                              } else if (state is PasswordConfirmToggled) {
                                isPasswordHidden = state.isHide;
                              }

                              return TextFormField(
                                controller: _confirmPasswordController,
                                validator: (value) =>
                                    TValidator.validatePassword(value),
                                obscureText: isPasswordHidden,
                                onChanged: (value) {
                                  context
                                      .read<PasswordMatchCubit>()
                                      .updateConfirmPassword(value);
                                },
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.confirmPass,
                                  prefixIcon:
                                      const Icon(Iconsax.password_check),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordHidden
                                          ? Iconsax.eye_slash
                                          : Iconsax.eye,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<PasswordConfirmCubit>()
                                          .togglePasswordConfirm();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          BlocBuilder<PasswordMatchCubit, PasswordMatchState>(
                            builder: (context, state) {
                              if (state is PasswordMatchUpdated &&
                                  !state.isMatch) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Passwords do not match!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: TSizes.md,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(ResetPasswordEvent(
                                params: ResetPasswordParams(
                                    email: widget.email,
                                    password:
                                        _passwordController.text.toString(),
                                    passwordConfirm: _confirmPasswordController
                                        .text
                                        .toString())));
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.submit)),
                  ),
                ],
              ),
            ),
            if (state is AuthLoading) const TLoader()
          ],
        );
      })),
    );
  }
}
