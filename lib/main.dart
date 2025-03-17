import 'package:chat_app/screens/ChatPage.dart';
import 'package:chat_app/screens/RegisterPage.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignInPage.id :(context)=>SignInPage(),
        Registerpage.id:(context)=>Registerpage(),
        Chatpage.id:(context)=>Chatpage(),

      },
      initialRoute:SignInPage.id ,
    );
  }
}
