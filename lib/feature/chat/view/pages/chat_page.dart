import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/chat_sevice.dart';
import 'package:chat_app/feature/chat/view_model/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(chatNotifier);
    var con = ref.read(chatNotifier);

    void sendMessage() async {
      if (con.controller.text.isNotEmpty) {
        chatService.sendMassege(receiverId, con.controller.text);
        con.controller.clear();
      }
    }

    Widget _buildUserInput() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  onSubmitted: (value) {
                    sendMessage();
                  },
                  controller: con.controller,
                  decoration: const InputDecoration(
                    hintText: "Type your message",
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward_outlined,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: _buildMessageList()),
            ),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = AuthService.auth.currentUser!.uid;
    return StreamBuilder(
      stream: chatService.getMassages(receiverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data["messages"]);
  }
}
