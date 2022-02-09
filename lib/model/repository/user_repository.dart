import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:land_app/model/entity/app_user.dart';

import 'authentication_repository.dart';

class UserRepository{
  final AuthenticationRepository _auth =  AuthenticationRepository();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

   Future changePassword(String password) async{
   //Create an instance of the current user. 
    User user =  _auth.user;
   
    //Pass in the password to updatePassword.
    await user.updatePassword(password).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  Future changeUsername(String username) async{
    User user =  _auth.user;
   
    await user.updateDisplayName(username).then((_){
      print("Successfully changed username");
    }).catchError((error){
      print("username can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  
   Future changeAvatar(String photoURL) async{
    User user =  _auth.user;
   
    await user.updatePhotoURL(photoURL).then((_){
      print("Successfully changed URL");
    }).catchError((error){
       print(" error" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
   Future<void> changePhoneNumber(String verificationId, String smsCode,
      BuildContext context,  String phone) async {
    try {
      // AuthCredential credential = PhoneAuthProvider.credential(
      //     verificationId: verificationId, smsCode: smsCode);
      // UserCredential userCredential =
      // await _firebaseAuth.signInWithCredential(credential);
      // User user =  _auth.user;
   
    // await user.updatePhoneNumber(PhoneAuthProvider.credential(
    //       verificationId: verificationId, smsCode: smsCode)).then((_){
    //   print("Successfully changed URL");
    // }).catchError((error){
    //    print(" error" + error.toString());
    //   //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    // });
     

      showSnackBar(context, "Xác thực số điện thoại thành công",
          Theme.of(context).colorScheme.primary);
      Navigator.pushNamedAndRemoveUntil(
          context,
         "/",
              (route) => false);
    } catch (e) {
      showSnackBar(context, "Xác thực số điện thoại không thành công. Vui lòng kiểm tra lại!",
          Theme.of(context).colorScheme.error);
    }
  }
 void showSnackBar(BuildContext context, String text, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<AppUser> getUserByUid (String uid) async{
    String? id; 
    print(uid);
    await FirebaseFirestore.instance.collection('users')
    .where('uid', isEqualTo: uid)
    .limit(1)
    .get()
    .then((snapshot)   {
        id = snapshot.docs[0].id;
      });
    var userRefs = FirebaseFirestore.instance.collection('users').withConverter<AppUser>(
      fromFirestore: (snapshot, _) => AppUser.fromMap(snapshot.data()!),
      toFirestore: (AppUser, _) => AppUser.toMap(),
    );
    AppUser user =  await userRefs.doc(id).get().then((snapshot) => snapshot.data()!);
    
    return Future<AppUser>.value(user); 
  }
}