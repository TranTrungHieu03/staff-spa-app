import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/network/connection_checker.dart';
import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/core/utils/service/auth_service.dart';
import 'package:staff_app/features/appointment/data/datasources/appoinment_remote_data_src.dart';
import 'package:staff_app/features/appointment/data/datasources/appoinment_remote_data_src.dart';
import 'package:staff_app/features/appointment/data/datasources/appoinment_remote_data_src.dart';
import 'package:staff_app/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';
import 'package:staff_app/features/appointment/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:staff_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:staff_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';
import 'package:staff_app/features/auth/domain/usecases/forget_password.dart';
import 'package:staff_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:staff_app/features/auth/domain/usecases/login.dart';
import 'package:staff_app/features/auth/domain/usecases/logout.dart';
import 'package:staff_app/features/auth/domain/usecases/resend_otp.dart';
import 'package:staff_app/features/auth/domain/usecases/reset_password.dart';
import 'package:staff_app/features/auth/domain/usecases/sign_up.dart';
import 'package:staff_app/features/auth/domain/usecases/verify_otp.dart';
import 'package:staff_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:staff_app/features/auth/presentation/bloc/on_boarding_bloc.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_confirm_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/password_match_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/policy_term_cubit.dart';
import 'package:staff_app/features/auth/presentation/cubit/remember_me_cubit.dart';
import 'package:staff_app/features/home/presentation/bloc/navigator/navigation_bloc.dart';
part "init_dependencies.main.dart";