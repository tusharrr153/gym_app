import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String gymname,
    required String address,
  }) async {
    String res = "Some error occurred";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("gymowner").doc(credential.user!.uid).set({
        'username': username,
        'email': email,
        'password': password,
        'gymname': gymname,
        'address': address,
        'uid': credential.user!.uid,
      });

      res = "User signed up successfully";
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

}
