import 'package:flutter/material.dart';
import 'package:gym/pages/complete_profile.dart';
import 'package:gym/pages/login_view.dart';
import 'package:gym/services/services.dart';
import '../common_widget/email_textfield.dart';
import '../common_widget/password_textfield.dart';
import '../common_widget/round_textfield.dart';
import '../common_widget/rounded_button.dart';
import '../services/google_auth.dart';

class SignView extends StatefulWidget {
  const SignView({Key? key}) : super(key: key);

  @override
  _SignViewState createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;
  bool _isLoading = false;

  void signUp() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
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
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == "User signed up successfully") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CompleteProfile()),
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
                  height: media.width * 0.3,
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    double maxWidth = constraints.maxWidth;
                    return ElevatedButton.icon(
                      onPressed: () async {
                        await FirebaseServices().signInWithGoogle();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => CompleteProfile()),
                        );
                      },
                      icon: Image.asset(
                        'assets/img/google.png', // Google logo asset
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text(
                        'Sign up with Google',
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
