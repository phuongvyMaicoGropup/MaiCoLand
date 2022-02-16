import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:land_app/model/repository/user_repository.dart';
import 'package:land_app/presentation/screens/register/verify_screen.dart';

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  final _userRepo = UserRepository();

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password); 
           await _userRepo.addUser(email, displayName, user.uid);
        await user.updateDisplayName(displayName).then((_) {
          print("Successfully changed username");
        }).catchError((error) {
          print("username can't be changed" + error.toString());
        });
      


      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
