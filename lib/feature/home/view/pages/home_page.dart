import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/chat_sevice.dart';
import 'package:chat_app/feature/chat/view/pages/chat_page.dart';
import 'package:chat_app/feature/home/view/pages/my_drawer.dart';
import 'package:chat_app/feature/home/view/widgets/w_user_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text('${user?.displayName}'),
      ),
      body: _buildListUsers(),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildListUsers() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!
              .map((userData) => _buildUserListItem(context, userData))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      BuildContext context, Map<String, dynamic> userData) {
    if (userData["email"] != AuthService.auth.currentUser?.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
                receiverId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
