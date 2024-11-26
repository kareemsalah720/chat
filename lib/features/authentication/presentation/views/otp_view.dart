import 'package:chat/features/authentication/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OTPVerificationView extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is PhoneAuthVerified) {
                  Navigator.pop(context);
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
                    final otpCode = _otpController.text.trim();
                    context.read<AuthCubit>().verifyOTP(otpCode);
                  },
                  child: const Text('Verify OTP'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
