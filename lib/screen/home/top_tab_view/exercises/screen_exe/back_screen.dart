import 'package:flutter/material.dart';

class BackScreen extends StatelessWidget {
  const BackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back Exercises'),
      ),
      body: Center(
        child: Text('This is the Back exercises screen.'),
      ),
    );
  }
}