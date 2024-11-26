part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded({required this.messages});
}

class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});
}

class ChatCleared extends ChatState {} 



































// part of 'chat_cubit.dart';

// @immutable
// sealed class ChatState {}

// final class ChatInitial extends ChatState {}

// class MessageLoading extends ChatState {}

// class MessageSuccess extends ChatState {}

// class MessageFailure extends ChatState {
//   final String error;
//   MessageFailure(this.error);
// }
// class MessageLoaded extends ChatState {
//   final List<MessageModel> messageList;
//   MessageLoaded(this.messageList);
// }