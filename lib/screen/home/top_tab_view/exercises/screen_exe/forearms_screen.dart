import 'package:flutter/material.dart';

class ForearmsScreen extends StatelessWidget {
  const ForearmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forearms Exercises'),
      ),
      body: Center(
        child: Text('This is the Forearms exercises screen.'),
      ),
    );
  }
}