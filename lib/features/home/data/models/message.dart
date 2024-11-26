
import 'package:chat/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Message {
  final String message;
  final DateTime createdAt;
  final String senderId;

  Message({required this.message, required this.createdAt, required this.senderId});
factory Message.fromJson( json) {
  return Message(
    message: json[FirebaseStrings.kMessage],
    createdAt: (json[FirebaseStrings.kCreatedAt] as Timestamp).toDate(),
    senderId: json[FirebaseStrings.senderId],
  );
}
}
