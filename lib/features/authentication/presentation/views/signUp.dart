import 'package:chat/core/utils/app_colors.dart';
import 'package:chat/core/utils/app_strings.dart';
import 'package:chat/features/authentication/cubit/auth_cubit.dart';
import 'package:chat/features/authentication/presentation/widgets/custom_TextFrom.dart';
import 'package:chat/features/authentication/presentation/widgets/secret_textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpEmailVerificationState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.checkYourEmail)));
                  Navigator.pop(context);
          }
          if (state is SignInSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.signUpSuccessfully)));
          
          } else if (state is SignUpErrorState) {
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
                    height: 150,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppStrings.signUp,
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
      CustomTextfrom(
                    labelText: AppStrings.name,
                    controller: context.read<AuthCubit>().name,
                    fKey: context.read<AuthCubit>().fromKeyName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfrom(
                    labelText: AppStrings.email,
                    controller: context.read<AuthCubit>().emailup,
                    fKey: context.read<AuthCubit>().fKeyemailUP,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecretTextform(
                    labelText: AppStrings.password,
                    controller: context.read<AuthCubit>().passup,
                    fKey: context.read<AuthCubit>().fKeyPassUp,
                    controller_parent: null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecretTextform(
                    labelText: AppStrings.confirmPassword,
                    controller: context.read<AuthCubit>().passup,
                    fKey: context.read<AuthCubit>().cfKeyPass,
                    controller_parent: null,
                  ),
                  state is SignUpLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          color: AppColors.primaryColor,
                          onPressed: () {
                            if (context
                                        .read<AuthCubit>()
                                        .fKeyemailUP
                                        .currentState!
                                        .validate() &&
                                    context
                                        .read<AuthCubit>()
                                        .fKeyPassUp
                                        .currentState!
                                        .validate() &&
                                    context
                                        .read<AuthCubit>()
                                        .cfKeyPass
                                        .currentState!
                                        .validate() &&
                                    context
                                        .read<AuthCubit>()
                                        .fromKeyName
                                        .currentState!
                                        .validate()
                                ) {
                              context.read<AuthCubit>().signUp();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child:  Text(
                            AppStrings.signUp,
                            style: TextStyle(
                              color: AppColors.white,
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
