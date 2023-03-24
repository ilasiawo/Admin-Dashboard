import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:test_farm/screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDaY4AYIv5cM4HgOVs5JLI2w-oJ7WjwLbY",
          authDomain: "farmonaut.firebaseapp.com",
          projectId: "farmonaut",
          storageBucket: "farmonaut.appspot.com",
          messagingSenderId: "836028099016",
          appId: "1:836028099016:web:b5a6dbe088cf9515c7f8fd",
          measurementId: "G-8LLJJZ92B5"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomAppBarColor: Colors.black12,
          scaffoldBackgroundColor: Color.fromARGB(255, 17, 76, 76),
          primaryColor: Color.fromARGB(255, 38, 65, 34)),
      home: const LandingScreen(),
    );
  }
}
