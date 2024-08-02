import 'package:flutter/material.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/abs_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/back_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/biceps_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/chest_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/forearms_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/legs_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/shoulders_screen.dart';
import 'package:gym/screen/home/top_tab_view/exercises/screen_exe/triceps_screen.dart';

import 'exercises_cell.dart';


class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  List<Map<String, String>> listArr = [
    {
      "title": "Chest",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_1.png"
    },
    {
      "title": "Back",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_2.png"
    },
    {
      "title": "Biceps",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_3.png"
    },
    {
      "title": "Triceps",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_4.png"
    },
    {
      "title": "Shoulders",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_5.png"
    },
    {
      "title": "Abs",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_6.png"
    },
    {
      "title": "Legs",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_7.png"
    },
    {
      "title": "Forearms",
      "subtitle": "10 Exercises",
      "image": "assets/img/ex_8.png"
    },
  ];

  void _navigateToScreen(String title) {
    switch (title) {
      case 'Chest':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChestScreen()),
        );
        break;
      case 'Back':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BackScreen()),
        );
        break;
      case 'Biceps':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BicepsScreen()),
        );
        break;
      case 'Triceps':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TricepsScreen()),
        );
        break;
      case 'Shoulders':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShouldersScreen()),
        );
        break;
      case 'Abs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AbsScreen()),
        );
        break;
      case 'Legs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LegsScreen()),
        );
        break;
      case 'Forearms':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForearmsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          var obj = listArr[index];

          return ExercisesCell(
            obj: obj,
            onPressed: () {
              _navigateToScreen(obj["title"]!);
            },
          );
        },
        itemCount: listArr.length,
      ),
    );
  }
}
