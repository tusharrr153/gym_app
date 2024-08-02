import 'package:flutter/material.dart';

class BicepsScreen extends StatelessWidget {
  const BicepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biceps Exercises'),
      ),
      body: Center(
        child: Text('This is the Biceps exercises screen.'),
      ),
    );
  }
}