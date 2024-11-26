import 'package:chat/core/functions/navigation.dart';
import 'package:chat/features/authentication/cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PhoneAuthView extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is PhoneAuthCodeSent) {
                customReplacementNavigate(context, '/otpScreen');
                } else if (state is PhoneAuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is PhoneAuthLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    final phoneNumber = _phoneController.text.trim();
                    context.read<AuthCubit>().sendOTP(phoneNumber);
                  },
                  child: const Text('Send OTP'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
