import 'package:chat_app/screens/ath_screen.dart';
//import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // textTheme: TextTheme.lerp(
        //   ThemeData.light().textTheme.copyWith(
        //         displayLarge: const TextStyle(
        //           color: Colors.black,
        //           fontSize: 40,
        //           fontWeight: FontWeight.bold,
        //         ),
        //         displaySmall: const TextStyle(
        //           color: Colors.black,
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //         ),
        //         bodyLarge: const TextStyle(
        //           color: Colors.black,
        //           //fontSize: 20,
        //           fontWeight: FontWeight.normal,
        //         ),
        //       ),
        //   ThemeData.dark().textTheme,
        //   1,
        // ),
        useMaterial3: true,
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context,snapshot){
        if(snapshot.hasData){
          return const ChatScreen();
        }
        return const AuthScreen();
      },),
    );
  }
}
