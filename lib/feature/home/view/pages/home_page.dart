import 'package:chat_app/feature/home/view/pages/my_drawer.dart';
import 'package:chat_app/feature/home/view_model/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeNotifier);
    final con = ref.read(homeNotifier);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text('Hi, ${user?.displayName}'),
      ),
      body: con.buildUi(),
      drawer: const MyDrawer(),
    );
  }

  //Unessecery

  // Widget _buildListUsers() {
  //   return StreamBuilder(
  //     stream: chatService.getUsersStream(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Text("Error");
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text("Loading...");
  //       }
  //       return ListView(
  //         children: snapshot.data!
  //             .map((userData) => _buildUserListItem(context, userData))
  //             .toList(),
  //       );
  //     },
  //   );
  // }

  // Widget _buildUserListItem(
  //     BuildContext context, Map<String, dynamic> userData) {
  //   if (userData["email"] != AuthService.auth.currentUser?.email) {
  //     return UserTile(
  //       text: userData['email'],
  //       onTap: () {
  //         //go to chat page
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ChatPage(
  //               receiverEmail: userData['email'],
  //               receiverId: userData["uid"],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }
}
