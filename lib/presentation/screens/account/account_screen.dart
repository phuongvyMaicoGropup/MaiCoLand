import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/helpers/pick_file.dart';
import 'package:land_app/helpers/storage.dart';
import 'package:land_app/logic/blocs/account/account_bloc/account_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/model/repository/user_repository.dart';
import 'package:land_app/presentation/resources/resources.dart';
import 'package:land_app/presentation/screens/account/widgets/widgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var _userRepo =  UserRepository();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(AccountLoad());
  }

  Future updateAvatar(BuildContext context) async {
    try{
 PickFile fileService = PickFile();
    String file = await fileService.pickImage(context);
    print(file);
    String url = await Storage.storageImage(context,File(file));
    print(url);
    await _userRepo.changeAvatar(url);
                   BlocProvider.of<AccountBloc>(context).add(AccountLoad());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: const Text("Cập nhập ảnh đại diện thành công!")));
        BlocProvider.of<AccountBloc>(context).add(AccountRefresh());
            BlocProvider.of<AccountBloc>(context).add(AccountLoad());
    }catch(e){
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: const Text("Cập nhập ảnh đại diện thất bại!")));
    }
   
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Center(
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
                  _buildContent(state),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  Widget _buildContent(AccountState state) {
    if (state is AccountLoaded) {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<AccountBloc>(context).add(AccountRefresh());
            BlocProvider.of<AccountBloc>(context).add(AccountLoad());
          },
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Column(children: [
                GestureDetector(
                    onTap: () => updateAvatar(context),
                    child: AccountAvatarWidget(
                      photoURL: state.user.photoURL.toString(),
                    )),
                const SizedBox(height: 10),
                buildTextField(
                    "Email ", state.user.email.toString(),  false),
                buildTextField(
                    "Tên đăng nhập ",
                    state.user.displayName.toString() != ""
                        ? state.user.displayName.toString()
                        : "Chưa cập nhập",
                    
                    true),
                buildTextField(
                    "Số điện thoại",
                    state.user.phoneNumber.toString() != "null"
                        ? state.user.phoneNumber.toString()
                        : "Chưa cập nhập",
                    
                    true),
                const SizedBox(
                  height: 35,
                ),
               
              ]),
            ],
          ),
        ),
      );
    } else if (state is AccountLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is AccountNotLoaded) {
      return const Expanded(
        child: Center(
          child: Text('Cannot load data'),
        ),
      );
    } else {
      return const Expanded(
        child: Center(
          child: Text('Unknown state'),
        ),
      );
    }
  }

  Widget buildTextField(
      String labelText, String placeholder,  bool canEdit) {
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
                      Navigator.of(context).pushNamed("/account_settings");
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
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary)),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
