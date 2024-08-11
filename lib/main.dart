import 'package:chatzy/services/auth/auth_gate.dart';
import 'package:chatzy/services/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatzy/themes/light_mode.dart';
import 'package:chatzy/services/auth/login_or_register.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){

    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAy-ssK0k6JEWksDt4w2RK9ti1_oYTe1zg",
        authDomain: "chatzy-8d0b9.firebaseapp.com",
        projectId: "chatzy-8d0b9",
        storageBucket: "chatzy-8d0b9.appspot.com",
        messagingSenderId: "1092155565727",
        appId: "1:1092155565727:web:1fbc8d6f02fd6b9dece4aa") );
  }else{
     await Firebase.initializeApp();
  }



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  AuthGate(),
      theme: light_Mode, // Ensure light_mode is of type ThemeData
    );
  }
}
