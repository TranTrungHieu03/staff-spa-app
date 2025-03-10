import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:staff_app/core/common/styles/spacing_styles.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/images.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/core/utils/validators/validation.dart';
import 'package:staff_app/features/auth/domain/usecases/login.dart';
import 'package:staff_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/remember_me_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<AuthBloc>().add(GetUserInformationEvent());
            } else if (state is AuthFailure) {
              TSnackBar.errorSnackBar(context, message: state.message);
            } else if (state is AuthLoaded) {
              goHome();
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: TSpacingStyles.paddingWithAppbarHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                          width: 160,
                          image: AssetImage(TImages.logo),
                        ),
                        Text(
                          AppLocalizations.of(context)!.welcomeBack,
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.primary),
                        ),
                        const SizedBox(
                          height: TSizes.sm,
                        ),
                        Text(
                          AppLocalizations.of(context)!.loginSub,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: TSizes.sm,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) => TValidator.validateEmail(value),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Iconsax.direct_right),
                                    labelText: AppLocalizations.of(context)!.email,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: TSizes.sm),
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
                                      validator: (value) => TValidator.validatePassword(value),
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!.password,
                                        prefixIcon: const Icon(Iconsax.password_check),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isPasswordHidden ? Iconsax.eye_slash : Iconsax.eye,
                                          ),
                                          onPressed: () {
                                            context.read<PasswordCubit>().togglePasswordVisibility();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Remember me
                                    Row(
                                      children: [
                                        BlocBuilder<RememberMeCubit, RememberMeState>(builder: (context, state) {
                                          bool isRemember = true;
                                          if (state is RememberMeInitial) {
                                            isRemember = state.isRemember;
                                          } else if (state is RememberMeToggle) {
                                            isRemember = state.isRemember;
                                          }
                                          return Checkbox(
                                              value: isRemember,
                                              onChanged: (newValue) {
                                                context.read<RememberMeCubit>().toggleRememberMe();
                                              });
                                        }),
                                        Text(AppLocalizations.of(context)!.rememberMe),
                                      ],
                                    ),
                                    //Forget Pass
                                    TextButton(
                                        onPressed: () => goForgotPassword(), child: Text(AppLocalizations.of(context)!.forgetPassword))
                                  ],
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
                                          context.read<AuthBloc>().add(LoginEvent(LoginParams(
                                              email: _emailController.text.toString().trim(),
                                              password: _passwordController.text.toString().trim())));
                                        }
                                      },
                                      child: Text(AppLocalizations.of(context)!.login.toUpperCase())),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.dontHaveAccount,
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    Center(
                                      child: TextButton(
                                        onPressed: () => goSignUp(),
                                        child: Text(
                                          AppLocalizations.of(context)!.createAccount,
                                          style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.primary),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                if (state is AuthLoading) const TLoader()
              ],
            );
          }),
        ));
  }
}
