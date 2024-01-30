import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_wall_social/auth/auth.dart';
import 'package:the_wall_social/pages/home_page.dart';
import 'package:the_wall_social/pages/profile_page.dart';
import 'package:the_wall_social/pages/user_page.dart';
import 'package:the_wall_social/theme/dark_mode.dart';
import 'package:the_wall_social/theme/light_mode.dart';

import 'auth/login_or_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,

      home:  AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
       '/login_register_page':(context)=>const LoginOrRegister(),
        '/home_page':(context)=>  HomePage(),
        '/profile_page':(context)=> ProfilePage(),
        '/user_page':(context)=> UserPage()
      }


    );
  }
}
