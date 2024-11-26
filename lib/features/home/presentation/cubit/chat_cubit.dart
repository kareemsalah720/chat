import 'package:chat/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/features/home/data/models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {}

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final email = FirebaseAuth.instance.currentUser!.email;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference messages = FirebaseFirestore.instance
      .collection(FirebaseStrings.kMessagesCollections);
  final TextEditingController controller = TextEditingController();

  void loadMessages() {
    emit(ChatLoading());
    try {
      messages
          .orderBy(FirebaseStrings.kCreatedAt, descending: true)
          .snapshots()
          .listen((snapshot) {
        List<Message> messagesList =
            snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
        emit(ChatLoaded(messages: messagesList));
      });
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  void sendMessage(email) {
    messages.add({
      FirebaseStrings.kMessage: controller.text,
      FirebaseStrings.kCreatedAt: DateTime.now(),
      FirebaseStrings.senderId: email,
    });
  }

  Future<void> deleteAllMessages() async {
    try {
      final batch = _firestore.batch();
      final snapshot = await messages.get();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      emit(ChatCleared());
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }
}
