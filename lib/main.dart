import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:chat_app/screens/ath_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'screens/chat_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  // await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
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
          useMaterial3: true,
        ),
        home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
            if(snapshot.hasData){
              FlutterNativeSplash.remove();
              return const ChatScreen();
            }
            return const AuthScreen();
          },),

      );
  }
}
