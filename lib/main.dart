import 'package:firebase_atuhenter/screen/dashboard.dart';
import 'package:firebase_atuhenter/screen/registrationscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screen/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBvjr-b4nfwjtXFzTBlr90dn_BlRpwnQVU",
            appId: "1:844565184418:web:6de444bc5e12ba5cd3fcfb",
            messagingSenderId: "844565184418",
            projectId: "fir-authenter"));
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const Dashboard()
      },
      title: "Flutter Firebase",
      theme: ThemeData(useMaterial3: true),
    );
  }
}
