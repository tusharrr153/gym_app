import 'package:flutter/material.dart';

class LegsScreen extends StatelessWidget {
  const LegsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legs Exercises'),
      ),
      body: Center(
        child: Text('This is the Legs exercises screen.'),
      ),
    );
  }
}