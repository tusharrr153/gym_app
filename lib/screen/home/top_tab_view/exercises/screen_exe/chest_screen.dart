import 'package:flutter/material.dart';

class ChestScreen extends StatelessWidget {
  const ChestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chest Exercises'),
      ),
      body: Center(
        child: Text('This is the Chest exercises screen.'),
      ),
    );
  }
}