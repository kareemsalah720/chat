import 'package:chat/features/authentication/presentation/views/otp_view.dart';
import 'package:chat/features/authentication/presentation/views/phone_number_view.dart';
import 'package:chat/features/authentication/presentation/views/signIn.dart';
import 'package:chat/features/authentication/presentation/views/signUp.dart';
import 'package:chat/features/home/presentation/views/home_view.dart';
import 'package:chat/features/splash/presentation/views/splashview.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const Splashview(),
  ),
  GoRoute(
    path: "/signUp",
    builder: (context, state) => const SignUp(),
  ),
  GoRoute(
    path: "/signIn",
    builder: (context, state) => const SignIn(),
  ),
  GoRoute(
    path: "/home",
    builder: (context, state) => HomeView(),
  ),
  GoRoute(
    path: "/otpScreen",
    builder: (context, state) => OTPVerificationView(),
  ),
  GoRoute(
    path: "/phoneNumberScreen",
    builder: (context, state) => PhoneAuthView(),
  ),
]);
