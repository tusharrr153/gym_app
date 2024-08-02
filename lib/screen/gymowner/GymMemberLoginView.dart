import 'package:flutter/material.dart';
import 'package:gym/screen/gymowner/homepage.dart';
import 'package:gym/screen/gymowner/signupowner.dart';

import '../../common_widget/email_textfield.dart';
import '../../common_widget/password_textfield.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/rounded_button.dart';
import '../../pages/complete_profile.dart';
import '../../pages/login_view.dart';

class GymMemberLoginView extends StatefulWidget {
  const GymMemberLoginView({super.key});

  @override
  State<GymMemberLoginView> createState() => _GymMemberLoginViewState();
}

class _GymMemberLoginViewState extends State<GymMemberLoginView> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gymnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;
  bool _isLoading = false;

  void signUp() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String gymname = _gymnameController.text.trim();
    String address = _addressController.text;
    String password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields'),
      ));
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String res = await AuthServices().signUpUser(
      username: username,
      email: email,
      gymname: gymname,
      address: address,
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == "User signed up successfully") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GymOwnerHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hey, there",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hintText: "Username",
                  icon: Icons.person_2_outlined,
                  controller: _usernameController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                EmailTextField(controller: _emailController),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hintText: "Gym name",
                  icon: Icons.person_2_outlined,
                  controller: _gymnameController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hintText: "full address",
                  icon: Icons.person_2_outlined,
                  controller: _addressController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                PasswordTextField(controller: _passwordController),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      icon: Icon(
                        isChecked
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "By continuing you accept our privacy policy and\nTerms of use",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 11),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.25,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : RoundedButton(
                  title: "Register",
                  onPressed: signUp,
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      "  Or  ",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
