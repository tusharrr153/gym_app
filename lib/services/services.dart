import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(credential.user!.uid).set({
        'username': username,
        'email': email,
        'password': password,
        'uid': credential.user!.uid,
      });

      res = "User signed up successfully";
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<String> completeUserProfile({
    required String gender,
    required String dateOfBirth,
    required String weight,
    required String height,
  }) async {
    String res = "Some error occurred";
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await _firestore.collection("users").doc(user.uid).update({
          'gender': gender,
          'dateOfBirth': dateOfBirth,
          'weight': weight,
          'height': height,
        });
        res = "Profile updated successfully";
      } else {
        res = "No user logged in";
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
}
