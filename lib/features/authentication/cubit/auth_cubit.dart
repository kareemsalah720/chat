import 'package:chat/core/utils/app_strings.dart';
import 'package:chat/features/authentication/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  // sginUp keys
  GlobalKey<FormState> fromKeyName = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> fKeyemailUP = GlobalKey<FormState>();
  TextEditingController emailup = TextEditingController();
  GlobalKey<FormState> fKeyphone = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> fKeyPassUp = GlobalKey<FormState>();
  TextEditingController passup = TextEditingController();
  GlobalKey<FormState> cfKeyPass = GlobalKey<FormState>();


// sginUp keys
  GlobalKey<FormState> fKeyemailIn = GlobalKey<FormState>();
  TextEditingController emailIn = TextEditingController();
  GlobalKey<FormState> fKeyPassIn = GlobalKey<FormState>();
  TextEditingController passIn = TextEditingController();
  final user = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  void signUp() async {
    try {
      emit(SignUpLoadingState());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailup.text,
        password: passup.text,
      );

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      emit(SignUpEmailVerificationState());
      bool emailVerified = false;

      while (!emailVerified) {
        await Future.delayed(const Duration(seconds: 5));
        await FirebaseAuth.instance.currentUser!.reload();
        emailVerified = await FirebaseAuth.instance.currentUser!.emailVerified;
        if (emailVerified) {
          addUser(UserModel(
            name: name.text,
            email: emailup.text,
          ));
          emit(SignUpSuccessState());
        }
      }
    } on FirebaseAuthException catch (e) {
      emit(SignUpErrorState(e.code));
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }

  signInWithGoogle() async {
    try {
      emit(GoolegleSignInLoadingState());
      signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(GoogleSignInSuccessState());
    } catch (e) {
      emit(GoogleSignInErrorState(e.toString()));
    }
  }

  void signIn() async {
    try {
      emit(SignInLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailIn.text,
        password: passIn.text,
      );

      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(SignInErrorState(e.code));
    } catch (e) {
      emit(SignInErrorState(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(SignOutLoadingState());
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(SignOutErrorState(e.toString()));
    }
  }

  addUser(UserModel userModel) async {
    await user.add({
      FirebaseStrings.name: userModel.name,
      FirebaseStrings.email: userModel.email,
    });
  }

  void deleteUser() async {
    try {
      emit(DeleteUserLoadingState());
      await user.doc(FirebaseAuth.instance.currentUser!.uid).delete();
      emit(DeleteUserSuccessState());
    } catch (e) {
      emit(DeleteUserErrorState(e.toString()));
    }
  }







Future<void> sendOTP(String phoneNumber) async {
    emit(PhoneAuthLoading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
        
          await _auth.signInWithCredential(credential);
          emit(PhoneAuthVerified());
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(PhoneAuthError(error: e.message ?? 'Verification Failed'));
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          emit(PhoneAuthCodeSent());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }


  Future<void> verifyOTP(String smsCode) async {
    emit(PhoneAuthLoading());
    try {
      if (_verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: smsCode,
        );
        await _auth.signInWithCredential(credential);
        emit(PhoneAuthVerified());
      } else {
        emit(PhoneAuthError(error: 'Verification ID is null'));
      }
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }




















}
