import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/account/widgets/widgets.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/presentation/widgets/text_icon.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({required this.userRepo, Key? key}) : super(key: key);

  final UserRepository userRepo;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _dioProvider = DioProvider();
  Future updateAvatar(BuildContext context) async {
    try {
      PickFile fileService = PickFile();
      String filePath = await fileService.pickImage(context);

      String url =
          await _dioProvider.uploadFile(filePath, "image/png", "avatar");
      print(url);
      // await _userRepo.changeAvatar(url);
      // BlocProvider.of<AccountBloc>(context).add(AccountLoad());
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text("Thông tin tài khoản"),
              ),
            ),
            backgroundColor: AppColors.white,
            body: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                color: AppColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
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
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(16, 138, 45, 1),
                          ),
                          child: Text(user.userName[0].toUpperCase(),
                              style: headingTextWhite),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.userName.toString(),
                                  style: headingText),
                              const SizedBox(
                                height: 3,
                              ),
                              TextIcon(Icons.email, user.email.toString()),
                              const SizedBox(
                                height: 3,
                              ),
                              TextIcon(
                                  Icons.phone,
                                  user.phoneNumber.toString() == ""
                                      ? "Chưa cập nhập"
                                      : user.phoneNumber.toString()),
                              const SizedBox(
                                height: 3,
                              ),
                            ])
                      ]),

                  // buildTextField(
                  //     "Tên đăng nhập ", user.userName.toString(), true),
                  // buildTextField(
                  //     "Số điện thoại",
                  //     user.phoneNumber.toString() != ""
                  //         ? user.phoneNumber.toString()
                  //         : "Chưa cập nhập",
                  //     true),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.appGreen2.withOpacity(0.7),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/news/save");
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Các tin đã lưu", style: whiteText),
                            Icon(Icons.arrow_right_sharp,
                                color: AppColors.white)
                          ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.appGreen2.withOpacity(0.7),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/landplanning/save");
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tin quy hoạch lưu trữ", style: whiteText),
                            Icon(Icons.arrow_right_sharp,
                                color: AppColors.white)
                          ]),
                    ),
                  )
                ]),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
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
              style: const TextStyle(fontSize: 16, color: AppColors.appGreen1)),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
