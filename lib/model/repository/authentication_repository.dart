import 'package:firebase_auth/firebase_auth.dart';
class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

 //SIGN UP METHOD
  Future signUp(
      {required String email,required String password,required String displayName}) async {
    try{

    print("signup begin");
    UserCredential userInfo = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("signup end");
    user.updateDisplayName(displayName).then((_){
      print("Successfully changed username");
    }).catchError((error){
      print("username can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
   
    return null; 
    } on FirebaseAuthException catch(e){
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