import 'package:chat/core/functions/navigation.dart';
import 'package:chat/core/utils/app_colors.dart';
import 'package:chat/core/utils/app_strings.dart';
import 'package:chat/core/utils/app_text_style.dart';
import 'package:chat/features/authentication/cubit/auth_cubit.dart';
import 'package:chat/features/home/presentation/widgets/chat_buble.dart';
import 'package:chat/features/home/presentation/cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatCubit>().loadMessages();
    final email = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    customReplacementNavigate(context, '/signIn');
                  },
                  icon: Icon(Icons.logout, color: AppColors.secondColor),
                ),
                title: Text(
                  AppStrings.logOut,
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ),
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  context.read<ChatCubit>().deleteAllMessages();
                  customReplacementNavigate(context, '/signIn');
                },
                icon: Icon(Icons.delete, color: AppColors.secondColor),
              ),
              title: Text(
                AppStrings.deleteAllMessages,
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppStrings.appName,style: CustomTextStyles.pacifico400style64.copyWith(color: Colors.white,fontSize: 30),),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Spacer();
              } else if (state is ChatLoaded) {
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isMe = message.senderId ==
                          FirebaseAuth.instance.currentUser!.email;
                      return isMe
                          ? ChatBuble(message: message)
                          : ChatBubleForFriend(message: message);
                    },
                  ),
                );
              } else if (state is ChatError) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is ChatCleared) {
                return const Center(child: Text('No messages available'));
              } else {
                return const Center(child: Text('No messages available'));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: context.read<ChatCubit>().controller,
              onSubmitted: (data) {
                if (data.isNotEmpty) {
                  context.read<ChatCubit>().sendMessage(email);
                  context.read<ChatCubit>().controller.clear();
                  
                }
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: AppStrings.sendMessage,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (context.read<ChatCubit>().controller.text.isNotEmpty) {
                      context.read<ChatCubit>().sendMessage(email);
                      context.read<ChatCubit>().controller.clear();
                    }
                    _controller.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  color: AppColors.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
