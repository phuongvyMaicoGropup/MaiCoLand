import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_repository.dart';

class UserRepository{
  final AuthenticationRepository _auth =  AuthenticationRepository();
   Future changePassword(String password) async{
   //Create an instance of the current user. 
    User user =  _auth.user;
   
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  Future changeUsername(String username) async{
    User user =  _auth.user;
   
    user.updateDisplayName(username).then((_){
      print("Successfully changed username");
    }).catchError((error){
      print("username can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  Future changePhoneNumber(String phoneNumber) async{
    User user =  _auth.user;
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (credential) async {
          await (await  _auth.user).updatePhoneNumberCredential(credential);
        },
        codeSent: (verificationId, [forceResendingToken]) async {
          String smsCode = "XXXX";
          final AuthCredential credential =
            PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
          await (await  _auth.user).updatePhoneNumberCredential(credential);
        }, verificationFailed: (FirebaseAuthException error) {  }, codeAutoRetrievalTimeout: (String verificationId) {  });
  }
  

}