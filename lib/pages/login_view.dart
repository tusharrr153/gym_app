import 'package:flutter/material.dart';
import 'package:gym/pages/home_page.dart';
import 'package:gym/pages/signup_view.dart';
import 'package:gym/pages/complete_profile.dart'; // Import CompleteProfile
import 'package:gym/services/google_auth.dart'; // Import AuthServices

import '../common_widget/email_textfield.dart';
import '../common_widget/password_textfield.dart';
import '../common_widget/rounded_button.dart';
import '../services/login_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields'),
      ));
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String res = await AuthServices2().loginUser(
      email: email,
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == "User logged in successfully") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
    }
  }

  void signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var user = await FirebaseServices().signInWithGoogle();
      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        // If the user is not null, they successfully signed in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in with Google: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
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
                  "Welcome Back",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                EmailTextField(controller: _emailController),
                SizedBox(
                  height: media.width * 0.04,
                ),
                PasswordTextField(controller: _passwordController),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 160),
                  child: Text(
                    "Forget password",
                    style: TextStyle(
                        color: Colors.purple.shade300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : RoundedButton(
                  title: "Login",
                  onPressed: login,
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    double maxWidth = constraints.maxWidth;
                    return ElevatedButton.icon(
                      onPressed: signInWithGoogle,
                      icon: Image.asset(
                        'assets/img/google.png', // Google logo asset
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: maxWidth * 0.25, // Adjust padding
                        ),
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignView()));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account yet?",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Register',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.purpleAccent.shade100,
                              fontSize: 14),
                        )
                      ],
                    ),
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
