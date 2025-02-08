import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spa_mobile/core/common/screens/success_screen.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_confirm_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/password_match_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/policy_term_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/cubit/remember_me_cubit.dart';
import 'package:spa_mobile/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:spa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:spa_mobile/features/auth/presentation/screens/set_password_screen.dart';
import 'package:spa_mobile/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:spa_mobile/features/auth/presentation/screens/verify_screen.dart';
import 'package:spa_mobile/features/home/presentation/blocs/navigation_bloc.dart';
import 'package:spa_mobile/features/home/presentation/screens/chat_ai_screen.dart';
import 'package:spa_mobile/features/home/presentation/screens/search_screen.dart';
import 'package:spa_mobile/features/home/presentation/widgets/navigator_menu.dart';
import 'package:spa_mobile/features/product/presentation/screens/checkout_screen.dart';
import 'package:spa_mobile/features/product/presentation/screens/history_screen.dart';
import 'package:spa_mobile/features/product/presentation/screens/my_cart_screen.dart';
import 'package:spa_mobile/features/product/presentation/screens/product_detail_screen.dart';
import 'package:spa_mobile/features/product/presentation/screens/shipment_information_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/booking_detail_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/booking_service_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/checkout_service_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/feedback_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/service_detail_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/service_history_screen.dart';
import 'package:spa_mobile/features/service/presentation/screens/status_service_screen.dart';
import 'package:spa_mobile/features/user/presentation/screens/profile_screen.dart';
import 'package:spa_mobile/init_dependencies.dart';

part 'navigators.dart';
