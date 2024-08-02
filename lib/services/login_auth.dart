import 'package:firebase_auth/firebase_auth.dart';

class AuthServices2 {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> loginUser({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return "User logged in successfully";
      } else {
        return "Failed to log in. Please check your credentials.";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
