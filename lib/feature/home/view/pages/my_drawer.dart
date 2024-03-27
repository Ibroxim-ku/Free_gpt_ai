import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/feature/auth/view/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hi👋, ${user?.displayName}",
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                leading: const Icon(
                  CupertinoIcons.settings,
                ),
                title: const Text(
                  "Setings",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ListTile(
                onTap: () async {
                  const urlView = "https://github.com";
                  await Share.share(
                      "Assalomu alaykum ayov yaxshimisiz \n\n$urlView");
                },
                leading: const Icon(
                  CupertinoIcons.share,
                ),
                title: const Text(
                  "Share",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text("Are you sure?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await AuthService.deleteAccount().then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                    (route) => false);
                              });
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                leading: const Icon(
                  Icons.delete_outline,
                ),
                title: const Text(
                  "Delete account",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () async {
                  await AuthService.logOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  });
                },
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text(
                  "Log out",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
