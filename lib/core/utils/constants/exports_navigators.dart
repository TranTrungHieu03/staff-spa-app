import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/core/common/screens/success_screen.dart';
import 'package:staff_app/features/appointment/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:staff_app/features/appointment/presentation/screens/appointment_detail_screen.dart';
import 'package:staff_app/features/appointment/presentation/screens/check_in_arrived_screen.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_confirm_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_match_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/policy_term_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/remember_me_cubit.dart';
import 'package:staff_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:staff_app/features/auth/presentation/screens/login_screen.dart';
import 'package:staff_app/features/auth/presentation/screens/on_boarding_screen.dart';
import 'package:staff_app/features/auth/presentation/screens/set_password_screen.dart';
import 'package:staff_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:staff_app/features/auth/presentation/screens/verify_screen.dart';
import 'package:staff_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:staff_app/features/home/presentation/bloc/navigator/navigation_bloc.dart';
import 'package:staff_app/features/home/presentation/widgets/navigator_menu.dart';
import 'package:staff_app/features/user/presentation/screens/profile_screen.dart';
import 'package:staff_app/features/working_time/presentation/screens/register_day_off_screen.dart';
import 'package:staff_app/features/working_time/presentation/screens/register_working_slot_screen.dart';
import 'package:staff_app/init_dependencies.dart';

part 'navigators.dart';
