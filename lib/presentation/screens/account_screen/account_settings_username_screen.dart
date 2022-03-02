import 'package:flutter/material.dart';

class AccountSettingsUsernameScreen extends StatefulWidget {
  const AccountSettingsUsernameScreen({ Key? key }) : super(key: key);

  @override
  _AccountSettingsUsernameScreenState createState() => _AccountSettingsUsernameScreenState();
}

class _AccountSettingsUsernameScreenState extends State<AccountSettingsUsernameScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title : Text("Chỉnh sửa ")
      )
    ));
  }
}