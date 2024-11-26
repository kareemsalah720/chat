import 'package:chat/core/functions/navigation.dart';
import 'package:chat/core/utils/app_colors.dart';
import 'package:chat/core/utils/app_strings.dart';
import 'package:chat/features/authentication/cubit/auth_cubit.dart';
import 'package:chat/features/authentication/presentation/widgets/custom_TextFrom.dart';
import 'package:chat/features/authentication/presentation/widgets/secret_textForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.signInSuccessfully)));

              customReplacementNavigate(context, '/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppStrings.pleaseVerifyYourEmailFirst)));
            }
          } else if (state is SignInErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }

          if (state is GoogleSignInSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.signInSuccessfully)));
            customReplacementNavigate(context, '/home');
          } else if (state is GoogleSignInErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/login.gif",
                    height: 300,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppStrings.signIn,
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CustomTextfrom(
                    labelText: AppStrings.email,
                    controller: context.read<AuthCubit>().emailIn,
                    fKey: context.read<AuthCubit>().fKeyemailIn,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecretTextform(
                    labelText: AppStrings.password,
                    controller: context.read<AuthCubit>().passIn,
                    fKey: context.read<AuthCubit>().fKeyPassIn,
                    controller_parent: null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppStrings.createAccount),
                      TextButton(
                        onPressed: () {
                          customReplacementNavigate(context, '/signUp');
                        },
                        child: const Text(AppStrings.signUp),
                      ),
                    ],
                  ),
                  state is SignInLoadingState
                      ? const CircularProgressIndicator()
                      : MaterialButton(
                          color: AppColors.primaryColor,
                          onPressed: () {
                            context.read<AuthCubit>().signIn();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            AppStrings.signIn,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                  state is GoolegleSignInLoadingState
                      ? const CircularProgressIndicator()
                      : MaterialButton(
                          color: AppColors.secondColor,
                          onPressed: () {
                            context.read<AuthCubit>().signInWithGoogle();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            AppStrings.signInwithGoogle,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: AppColors.white,
                          onPressed: () {
                          customReplacementNavigate(context, '/phoneNumberScreen');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Sign in with Phone Number',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 20,
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
