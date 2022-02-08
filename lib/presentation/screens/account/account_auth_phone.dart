import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:land_app/model/repository/user_repository.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

enum MobileVerificationState{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OPT_FORM_STATE
}


class AccountAuthPhone extends StatefulWidget {
  final User user ;
  const AccountAuthPhone( {required  this.user })  ;

  @override
  _AccountAuthPhoneState createState() => _AccountAuthPhoneState();
}

class _AccountAuthPhoneState extends State<AccountAuthPhone> {

  var _userRepo = UserRepository();
  var _currenState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  var verificationId ;
  final _phonenumberController = TextEditingController();
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
     return Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children : <Widget> [
                  Text("Mã xác thực",
                      style : TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color : Theme.of(context).colorScheme.primary,
                      )),
                  const SizedBox(height: 50),
                  textField(),
                  const SizedBox(
                    height : 30,
                  )
                ]
              )
            )
            ,optField(),
          ])));
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
      ),
      child: TextFormField(
        controller: _phonenumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(

            border: InputBorder.none,
            hintText: "(+84)",
            hintStyle: const TextStyle(color: Colors.black12, fontSize: 12),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 20),

            suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextButton(
                  child :  Text(" Gửi ",
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),),

                  onPressed:() async {
                    String phone = _phonenumberController.text.substring(1);
                    phone ="+84"+phone;
                    print(phone);
                    if (validNumber(_phonenumberController.text)) {
                      await auth.verifyPhoneNumber(
                        phoneNumber: "+84788892441",
                        verificationCompleted: (AuthCredential credential) async {
                          // await auth.signInWithCredential(credential); 
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            print('The provided phone number is not valid.');
                          }
                          else print(e.code);

                          // Handle other errors
                        },
                        codeSent: (String verificationId, int? resendToken) async {
                          setState(()=> {_currenState = MobileVerificationState.SHOW_OPT_FORM_STATE});
                          // Update the UI - wait for the user to enter the SMS code
                          this.verificationId = verificationId;
                          print("codeSent");
                          // Create a AccountAuthPhoneCredential with the code
                          print(verificationId);
                        },
                        timeout: const Duration(seconds: 60),
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // Auto-resolution timed out...
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: const Text('Đang gửi mã xác thực', style : TextStyle(color: Colors.white)),backgroundColor: Theme.of(context).colorScheme.primary,),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Số điện thoại không hợp lệ vui lòng nhập lại.'),backgroundColor: Theme.of(context).colorScheme.error,),
                      );                                              
                    }

                  } ,
                )

            )
        ),

      ),

    );
  }
  bool validNumber(String? value){
      if (value == "") {
        return false;
      }
      else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(value!) || value.length > 10)
        return false;

      return true;

  }
  Widget optField() {
    if (_currenState == MobileVerificationState.SHOW_MOBILE_FORM_STATE)
      return const Text("*Vui lòng nhập số điện thoại để nhận mã xác thực!", style : TextStyle(fontSize : 14, fontStyle: FontStyle.italic, color : Colors.black54));
    else {
      return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width-120,
      fieldWidth: 30,
      style: const TextStyle(fontSize: 15,),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin)  {
        _userRepo.changePhoneNumber(verificationId, pin, context,_phonenumberController.text);
      },
    );
    }
  }

  
}
