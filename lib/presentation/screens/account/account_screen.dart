import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/bloc/auth_bloc/auth_bloc.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/account/widgets/widgets.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({required this.userRepo, Key? key}) : super(key: key);

  final UserRepository userRepo;

  Future updateAvatar(BuildContext context) async {
    try {
      PickFile fileService = PickFile();
      String file = await fileService.pickImage(context);
      print(file);
      // String url = await Storage.storageImage(context,File(file));
      // print(url);
      // await _userRepo.changeAvatar(url);
      //                BlocProvider.of<AccountBloc>(context).add(AccountLoad());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: const Text("Cập nhập ảnh đại diện thành công!")));
      // BlocProvider.of<AccountBloc>(context).add(AccountRefresh());
      // BlocProvider.of<AccountBloc>(context).add(AccountLoad());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text("Cập nhập ảnh đại diện thất bại!")));
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                color: AppColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Center(
                      child: Text("Thông tin tài khoản",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    _buildContent(),
                  ],
                ),
              ),
            )));
  }

  Widget _buildContent() {
    late User user;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          user = state.userReponse;
          return Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Column(children: [
                  GestureDetector(
                      onTap: () => updateAvatar(context),
                      child: AccountAvatarWidget(
                        photoURL: user.photoURL.toString(),
                      )),
                  const SizedBox(height: 10),
                  buildTextField("Email ", user.email.toString(), false),
                  buildTextField(
                      "Tên đăng nhập ", user.userName.toString(), true),
                  buildTextField(
                      "Số điện thoại",
                      user.phoneNumber.toString() != ""
                          ? user.phoneNumber.toString()
                          : "Chưa cập nhập",
                      true),
                  const SizedBox(
                    height: 35,
                  ),
                ]),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool canEdit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(labelText, style: const TextStyle(fontSize: 18)),
            canEdit
                ? GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed("/account_settings");
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  )
                : Container(),
          ]),
          const SizedBox(height: 10),
          Text(placeholder,
              style: TextStyle(fontSize: 16, color: AppColors.appGreen1)),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
