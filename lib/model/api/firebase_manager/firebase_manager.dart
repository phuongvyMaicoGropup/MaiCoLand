import 'package:firebase_auth/firebase_auth.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class FirebaseManager {
  String verificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseManager() {
    auth = FirebaseAuth.instance;
  }
  Future<void> SendSMSVerified(BuildContext context, String phoneNumber) async {
    phoneNumber = phoneNumber.substring(1, phoneNumber.length);
    await auth.verifyPhoneNumber(
        phoneNumber: "+84" + phoneNumber,
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        timeout: const Duration(seconds: 60));
  }

  Future<bool> CheckOTPCode(BuildContext context, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    try {
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }
}
