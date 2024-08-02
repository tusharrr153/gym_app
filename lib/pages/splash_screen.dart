
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/signup_view.dart';
import 'package:gym/screen/select.dart';

import '../common_widget/rounded_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SafeArea(
        child: Column(

          children: [
            Image.asset("assets/img/Group.png"),
            SizedBox(
              height: media.width * 0.04,
            ),
            Text.rich(
              TextSpan(
                  text: 'Fitnest',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'X',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent.shade100,fontSize: 30),)
                ]
              )
            ),
            Text(
                "Everybody can train",
                 style: TextStyle(color: Colors.grey,fontSize: 14,),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RoundedButton(
                title: "Get Started",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
