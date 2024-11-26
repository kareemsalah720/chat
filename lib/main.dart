import 'package:chat/core/app/chat_app.dart';
import 'package:chat/core/functions/check_state_changes.dart';
import 'package:chat/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

  checkStateChanges();
  await  FirebaseNotifications().initNotifications();
  runApp(ChatApp());
}
