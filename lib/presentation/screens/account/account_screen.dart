import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/presentation/resources/resources.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future updateAvatar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: const Text("Cập nhập ảnh đại diện thành công!")));
  }

  @override
  Widget build(BuildContext context) {
    User user = RepositoryProvider.of<AuthenticationRepository>(context).user;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const Center(
                  child: Text("Thông tin tài khoản",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/default_avatar.png"))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: GestureDetector(
                              onTap: () => updateAvatar(context),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                buildTextField("Email ", user.email!, false),
                buildTextField(
                    "Tên đăng nhập ",
                    user.displayName! != ""
                        ? user.displayName!
                        : "Chưa cập nhập",
                    false),
                buildTextField(
                    "Số điện thoại",
                    user.phoneNumber! != ""
                        ? user.phoneNumber!
                        : "Chưa cập nhập",
                    false),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.all(10),
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/account_settings");
                        },
                        padding: const EdgeInsets.all(10.0),
                        color: Theme.of(context).colorScheme.primary,
                        textColor: Colors.white,
                        child:
                            const Text("Sửa", style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        onPressed: () {
                          setState(() async {
                            Navigator.pop(context, (route) => false);
                          });
                        },
                        padding: const EdgeInsets.all(10.0),
                        color: Colors.white,
                        textColor: Theme.of(context).colorScheme.primary,
                        child: const Text("Quay lại",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(labelText, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 5),
          Text(placeholder,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary)),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
