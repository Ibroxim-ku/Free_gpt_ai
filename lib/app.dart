import 'package:chat_app/core/controllers/theme_controller.dart';
import 'package:chat_app/feature/splash/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeNotifier);
    var con = ref.read(themeNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.deepOrange,
              onSecondary: Colors.white,
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.blueGrey,
              onPrimary: Colors.white,
              secondary: Colors.blueGrey,
              onSecondary: Colors.white,
            ),
      ),
      themeMode: con.isChanged ? ThemeMode.dark : ThemeMode.light,
      home: SplashPage(),
    );
  }
}
