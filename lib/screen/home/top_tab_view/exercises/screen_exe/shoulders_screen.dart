import 'package:flutter/material.dart';

class ShouldersScreen extends StatelessWidget {
  const ShouldersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoulders Exercises'),
      ),
      body: Center(
        child: Text('This is the Shoulders exercises screen.'),
      ),
    );
  }
}