import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/loader.dart';
import 'package:spa_mobile/core/common/widgets/show_snackbar.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/core/utils/validators/validation.dart';
import 'package:spa_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_confirm_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_match_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/policy_term_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            goVerify(_emailController.text.toString(), 1);
          } else if (state is AuthFailure) {
            TSnackBar.errorSnackBar(context, message: state.message);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.signUpTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: TColors.primary),
                        ),
                        const SizedBox(
                          height: TSizes.sm,
                        ),
                        Text(
                          AppLocalizations.of(context)!.signUpSub,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: TSizes.md,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) =>
                                      TValidator.validateEmail(value),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Iconsax.direct_right),
                                    labelText:
                                        AppLocalizations.of(context)!.email,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: TSizes.sm),
                                TextFormField(
                                  controller: _usernameController,
                                  validator: (value) =>
                                      TValidator.validateEmptyText(
                                          AppLocalizations.of(context)!
                                              .username,
                                          value),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Iconsax.user_edit),
                                    labelText:
                                        AppLocalizations.of(context)!.username,
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(height: TSizes.sm),
                                TextFormField(
                                  controller: _phoneController,
                                  validator: (value) =>
                                      TValidator.validateEmptyText(
                                          AppLocalizations.of(context)!.phone,
                                          value),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Iconsax.call),
                                    labelText:
                                        AppLocalizations.of(context)!.phone,
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: TSizes.sm),
                                BlocBuilder<PasswordCubit, PasswordState>(
                                  builder: (context, state) {
                                    bool isPasswordHidden = true;

                                    if (state is PasswordInitial) {
                                      isPasswordHidden = state.isPasswordHidden;
                                    } else if (state
                                        is PasswordVisibilityToggled) {
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
                                        labelText: AppLocalizations.of(context)!
                                            .password,
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
                                    } else if (state
                                        is PasswordConfirmToggled) {
                                      isPasswordHidden = state.isHide;
                                    }

                                    return TextFormField(
                                      validator: (value) =>
                                          TValidator.validatePassword(value),
                                      obscureText: isPasswordHidden,
                                      onChanged: (value) {
                                        context
                                            .read<PasswordMatchCubit>()
                                            .updateConfirmPassword(value);
                                      },
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .confirmPass,
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
                                BlocBuilder<PasswordMatchCubit,
                                    PasswordMatchState>(
                                  builder: (context, state) {
                                    if (state is PasswordMatchUpdated &&
                                        !state.isMatch) {
                                      return Text(
                                        "Passwords do not match!",
                                        style: TextStyle(color: Colors.red),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  },
                                ),
                                const SizedBox(
                                  width: TSizes.spacebtwItems,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<PolicyTermCubit,
                                            PolicyTermState>(
                                        builder: (context, state) {
                                      bool isAccept = true;
                                      if (state is PolicyTermInitial) {
                                        isAccept = state.isAccept;
                                      } else if (state is PolicyTermToggled) {
                                        isAccept = state.isAccept;
                                      }
                                      return Checkbox(
                                          value: isAccept,
                                          onChanged: (newValue) {
                                            context
                                                .read<PolicyTermCubit>()
                                                .togglePolicyTerm();
                                          });
                                    }),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .iAgreeTo,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .privacyPolicy,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .apply(
                                                      color: dark
                                                          ? TColors.white
                                                          : TColors.primary,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: dark
                                                          ? TColors.white
                                                          : TColors.primary),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) {
                                                        return Container(
                                                          padding: const EdgeInsets
                                                              .all(TSizes
                                                                  .defaultSpace),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(AppLocalizations
                                                                      .of(context)!
                                                                  .privacyPolicy),
                                                              Text(AppLocalizations
                                                                      .of(context)!
                                                                  .privacyDetail),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                }),
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .and,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .termOfUse,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .apply(
                                                      color: dark
                                                          ? TColors.white
                                                          : TColors.primary,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: dark
                                                          ? TColors.white
                                                          : TColors.primary),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) {
                                                        return Container(
                                                          padding: const EdgeInsets
                                                              .all(TSizes
                                                                  .defaultSpace),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(AppLocalizations
                                                                      .of(context)!
                                                                  .termOfUse),
                                                              Text(AppLocalizations
                                                                      .of(context)!
                                                                  .termOfUseDetail),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                }),
                                        ]),
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                ),
                                BlocBuilder<PolicyTermCubit, PolicyTermState>(
                                  builder: (context, state) {
                                    if (state is PolicyTermError) {
                                      return Text(
                                        state.message,
                                        style: TextStyle(color: Colors.red),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  },
                                ),
                                const SizedBox(
                                  height: TSizes.spacebtwSections / 2,
                                ),
                                //sign in
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<PolicyTermCubit>()
                                              .validatePolicyTerm();

                                          context.read<AuthBloc>().add(
                                              SignUpEvent(
                                                  email: _emailController.text
                                                      .toString(),
                                                  password: _passwordController
                                                      .text
                                                      .toString(),
                                                  role: "Customer",
                                                  userName: _usernameController
                                                      .text
                                                      .toString(),
                                                  phoneNumber: _phoneController
                                                      .text
                                                      .toString()));
                                        }
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .createAccount)),
                                ),
                                const SizedBox(
                                  width: TSizes.spacebtwItems,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                if (state is AuthLoading) const TLoader()
              ],
            );
          },
        ),
      ),
    );
  }
}
