import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing/firebase_options.dart';
import 'package:firebase_testing/screens/google_sign_in_screen.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth Web',
      home: SignInScreen(),
    );
  }
}