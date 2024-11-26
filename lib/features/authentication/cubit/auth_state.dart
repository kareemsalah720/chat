part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignInLoadingState extends AuthState {}

final class SignInSuccessState extends AuthState {}

final class SignInErrorState extends AuthState {
  final String error;
  SignInErrorState(this.error);
}

final class SignUpLoadingState extends AuthState {}

final class SignUpSuccessState extends AuthState {}

final class SignUpErrorState extends AuthState {
  final String error;
  SignUpErrorState(this.error);
}

final class GoolegleSignInLoadingState extends AuthState {}

final class GoogleSignInSuccessState extends AuthState {}

final class GoogleSignInErrorState extends AuthState {
  final String error;
  GoogleSignInErrorState(this.error);
}

final class SignOutLoadingState extends AuthState {}

class SignUpEmailVerificationState extends AuthState {}

final class SignOutSuccessState extends AuthState {}

final class SignOutErrorState extends AuthState {
  final String error;
  SignOutErrorState(this.error);
}

final class DeleteUserLoadingState extends AuthState {}

final class DeleteUserSuccessState extends AuthState {}

final class DeleteUserErrorState extends AuthState {
  final String error;
  DeleteUserErrorState(this.error);
}

class PhoneAuthInitial extends AuthState {}

class PhoneAuthLoading extends AuthState {}

class PhoneAuthCodeSent extends AuthState {}

class PhoneAuthVerified extends AuthState {}

class PhoneAuthLoggedOut extends AuthState {}

class PhoneAuthError extends AuthState {
  final String error;
  PhoneAuthError({required this.error});
}
