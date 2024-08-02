import 'package:flutter/material.dart';

class TricepsScreen extends StatelessWidget {
  const TricepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Triceps Exercises'),
      ),
      body: Center(
        child: Text('This is the Triceps exercises screen.'),
      ),
    );
  }
}