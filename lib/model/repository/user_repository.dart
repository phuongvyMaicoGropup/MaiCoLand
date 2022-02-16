import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:land_app/model/entity/app_user.dart';

import 'authentication_repository.dart';

class UserRepository {
  // final AuthenticationRepository _auth = AuthenticationRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future changePassword(String password) async {
    User user = _auth.currentUser!;
    await user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }

  Future changeUsername(String username) async {
    User user = _auth.currentUser!;
    await user.updateDisplayName(username).then((_) {
      print("Successfully changed username");
    }).catchError((error) {
      print("username can't be changed" + error.toString());
    });
  }

  Future changeAvatar(String photoURL) async {
    User user = _auth.currentUser!;

    await user.updatePhotoURL(photoURL).then((_) {
      print("Successfully changed URL");
    }).catchError((error) {
      print(" error" + error.toString());
    });
  }

  Future<void> changePhoneNumber(String verificationId, String smsCode,
      BuildContext context, String phone) async {
    try {
      User user = _auth.currentUser!;
      String uid = user.uid;

      await user
          .updatePhoneNumber(PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode))
          .then((_) async {
        print("Successfully changed URL");
        String userDoc = await getDocByUid(uid);
        await users
            .doc(userDoc)
            .update({'phoneNumber': phone})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      }).catchError((error) {
        print(" error" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });

      showSnackBar(context, "Xác thực số điện thoại thành công",
          Theme.of(context).colorScheme.primary);
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } catch (e) {
      showSnackBar(
          context,
          "Xác thực số điện thoại không thành công. Vui lòng kiểm tra lại!",
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

  Future<AppUser> getUserByUid(String uid) async {
    AppUser user = AppUser(
        uid: "",
        email: "email",
        photoURL: "photoURL",
        phoneNumber: "phoneNumber",
        displayName: "displayName");
    // print("uid =- ");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot data) {
      if (data.exists) {
        print('Document exists on the database');
        user = AppUser(
            uid: data["uid"],
            email: data["email"],
            photoURL: data["photoURL"],
            phoneNumber: data["phoneNumber"],
            displayName: data["displayName"]);
      }
    });

    // print(user);
    return Future<AppUser>.value(user);
  }

  Future<String> getDocByUid(String uid) async {
    String docId = "";
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        docId = doc.id;
      }
    });

    // print(user);
    return Future<String>.value(docId);
  }
  Future<void> addUser(String email , String displayName, String uid ) {
      return users
          .add({
            'uid': uid, 
            'phoneNumber': '', 
            'email': email,
            'displayName': displayName,
            'photoURL': 'https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/avatar%2Fdefault_avatar.png?alt=media&token=9f1c337b-1135-4aa9-9ff8-2529f3590af5' 
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
}
