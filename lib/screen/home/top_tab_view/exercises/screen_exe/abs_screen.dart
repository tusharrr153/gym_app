import 'package:flutter/material.dart';

class AbsScreen extends StatelessWidget {
  const AbsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abs Exercises'),
      ),
      body: Center(
        child: Text('This is the Abs exercises screen.'),
      ),
    );
  }
}