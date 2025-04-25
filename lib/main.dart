import 'package:chat_app/Cubit/chat_cubit.dart';
import 'package:chat_app/Cubit/login_cubit.dart';
import 'package:chat_app/Cubit/register_cubit.dart';
import 'package:chat_app/screens/ChatPage.dart';
import 'package:chat_app/screens/RegisterPage.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>ChatCubit())
      ],
      child: MaterialApp(
        routes: {
          SignInPage.id: (context) => SignInPage(),
          Registerpage.id: (context) => Registerpage(),
          Chatpage.id: (context) => Chatpage(),
        },
        initialRoute: SignInPage.id,
      ),
    );
  }
}
