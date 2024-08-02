import 'package:flutter/material.dart';
import 'package:gym/screen/home/top_tab_view/workout_plan/workout_plan_screen.dart';
import '../../../color/color_extension.dart';
import 'challenges/challenges_tab_screen.dart';
import 'exercises/exercises_tab_screen.dart';
import 'health_tip/health_tip_screen.dart';

class TopTabViewScreen extends StatefulWidget {
  const TopTabViewScreen({super.key});

  @override
  State<TopTabViewScreen> createState() => _TopTabViewScreenState();
}

class _TopTabViewScreenState extends State<TopTabViewScreen>
    with SingleTickerProviderStateMixin {
  var tapArr = [
    "Health Tips",
    "Exercises",
    "Workout Plan",
    "Challenges",
  ];

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tapArr.length, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: TColor.secondary,
          titleSpacing: -110,
          title: TabBar(
            controller: controller,
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            unselectedLabelColor: Colors.white70,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            tabs: tapArr.map((name) => Tab(text: name)).toList(),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          HealthTipScreen(),
          ExercisesScreen(),
          WorkoutPlanScreen(),
          ChallengesScreen(),
        ],
      ),
    );
  }
}
