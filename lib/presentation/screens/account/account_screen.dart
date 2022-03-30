import 'dart:math';

import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({required this.userRepo, Key? key}) : super(key: key);

  final UserRepository userRepo;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _dioProvider = DioProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   title: const Center(
            //     child: Text("Thông tin tài khoản"),
            //   ),
            // ),
            backgroundColor: AppColors.appGreen1,
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
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Thông tin tài khoản",
                          style: headingText.copyWith(fontSize: 25)),
                      const SizedBox(height: 30),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    radius: 30,
                                    child: Text(user.userName[0].toUpperCase(),
                                        style: headingTextWhite)),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(user.userName.toString(),
                                          style: headingText),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      // TextIcon(Icons.email, user.email.toString()),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Text(user.phoneNumber.toString() == ""
                                          ? "Chưa cập nhập"
                                          : user.phoneNumber.toString()),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                    ]),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.auto_fix_normal)),
                            )
                          ]),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text("Kho lưu trữ", style: textMinorGrayTitle),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildRow(Icons.newspaper, const Color(0xFFF08F8F),
                          "Tin tức", "/news/save", ""),
                      const SizedBox(height: 10),
                      _buildRow(Icons.map_outlined, const Color(0xFF6DC882),
                          "Tin quy hoạch", "/landplanning/save", ""),
                      const SizedBox(height: 15),
                      const Text("Tin của bạn", style: textMinorGrayTitle),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildRow(Icons.newspaper, const Color(0xFFEEF08F),
                          "Tin tức", "/account/news", user.id),
                      const SizedBox(height: 10),
                      _buildRow(Icons.map_outlined, const Color(0xFFFE91B0),
                          "Tin quy hoạch", "/account/landplanning", user.id),
                      const SizedBox(height: 15),
                      const Text("Tài khoản", style: textMinorGrayTitle),
                      const SizedBox(height: 10),
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.appErrorRed.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Đăng xuất",
                                    style: mediumText.copyWith(
                                        fontSize: 16, color: AppColors.white)),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                )
                              ]))
                    ]),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildRow(
      IconData icon, Color? color, String label, String link, String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Icon(icon, color: Colors.white, size: 20),
              backgroundColor: color,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(label, style: textMediumBlack.copyWith(fontSize: 18)),
          ],
        ),
        IconButton(
            onPressed: () => _maptoNewPage(link, id),
            icon: const Icon(Icons.arrow_forward_ios_outlined))
      ],
    );
  }

  _maptoNewPage(String link, String id) {
    Navigator.of(context).pushNamed(link, arguments: id);
  }
}
