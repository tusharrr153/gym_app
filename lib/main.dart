import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:gym/pages/home_page.dart';
import 'package:gym/pages/login_view.dart';
import 'package:gym/pages/signup_view.dart';
import 'package:gym/pages/splash_screen.dart';
import 'package:gym/screen/gymowner/homepage.dart';
import 'package:gym/screen/select.dart'; // Adjust the path accordingly

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context,snapshot){
        if(snapshot.hasData)
          {
            return HomePage();
          }else{
          return  HomePage();
        }
      },)
    );
  }
}
