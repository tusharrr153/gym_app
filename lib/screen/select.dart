import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common_widget/rounded_button.dart';
import '../pages/signup_view.dart';
import '../pages/login_view.dart'; // Assuming this is the screen for Gym Owner login

import 'gymowner/GymMemberLoginView.dart'; // Assuming this is the screen for Gym Member login

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  // Track which container is selected
  String selectedRole = 'Gym Member'; // Default selection

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding around the content
        child: Column(
          children: [
            SizedBox(height: 40), // Space from the top of the screen
            Text(
              "Select Your Role",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center, // Center align the text
            ),
            Spacer(), // Pushes the next content to the center
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space containers evenly
              children: [
                // First Container - Gym Owner
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = 'Gym Owner';
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300), // Animation duration for size change
                    width: selectedRole == 'Gym Owner' ? media.width * 0.45 : media.width * 0.4,
                    height: selectedRole == 'Gym Owner' ? 250 : 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: selectedRole == 'Gym Owner'
                            ? [Color(0xB364B5F6), Color(0xB3BA68C8)]
                            : [Color(0xE0B9B9B7), Color(0xE0E0E0FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/gymowner.png', // Replace with your image path
                          height: 160.0, // Image height
                          width: 100.0, // Image width
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Gym Owner',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second Container - Gym Member
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = 'Gym Member';
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300), // Animation duration for size change
                    width: selectedRole == 'Gym Member' ? media.width * 0.45 : media.width * 0.4,
                    height: selectedRole == 'Gym Member' ? 250 : 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: selectedRole == 'Gym Member'
                            ? [Color(0xB364B5F6), Color(0xB3BA68C8)]
                            : [Color(0xE0B9B9B7), Color(0xE0E0E0FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/gymmember.png', // Replace with your image path
                          height: 140.0, // Image height
                          width: 100.0, // Image width
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Gym Member',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(), // Pushes the button to the bottom
            RoundedButton(
              title: 'Continue',
              onPressed: () {
                // Navigate to different screens based on the selectedRole
                if (selectedRole == 'Gym Owner') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GymMemberLoginView()), // Replace with your Gym Member login view
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()), // Replace with your Gym Owner login view
                  );
                }
              },
            ),
            SizedBox(height: 20), // Add some space below the button
          ],
        ),
      ),
    );
  }
}
