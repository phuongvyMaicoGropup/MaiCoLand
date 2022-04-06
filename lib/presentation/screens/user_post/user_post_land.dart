import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/presentation/screens/account_post/account_land.dart';
import 'package:maico_land/presentation/screens/account_post/account_news.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/widgets/text_icon.dart';

class UserPostLand extends StatefulWidget {
  UserPostLand({Key? key, this.author}) : super(key: key);
  User? author;
  @override
  State<UserPostLand> createState() => _UserPostLandState();
}

class _UserPostLandState extends State<UserPostLand>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: const Text('Tài khoản'),
        centerTitle: true,
      ),
      body: Container(
          child: widget.author != null
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 15),
                                child: widget.author!.photoURL == ""
                                    ? CircleAvatar(
                                        backgroundColor: AppColors.appGreen1,
                                        child: Text(
                                          widget.author!.userName[0],
                                          style: textMediumWhite,
                                        ),
                                        radius: 30,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            widget.author!.photoURL),
                                        radius: 30,
                                      ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.author!.fullName,
                                style: textLargeGreen,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // const Text(
                              //   " Liên hệ ",
                              //   style: textMiniBlack,
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              TextIcon(
                                Icons.phone,
                                widget.author!.phoneNumber,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextIcon(
                                Icons.email,
                                widget.author!.email,
                              ),
                            ],
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Align(
                      //       alignment: Alignment.topLeft,
                      //       child: const Text(
                      //         " Bài viết liên quan ",
                      //         style: textMediumBlack,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      TabBar(
                          controller: _tabController,
                          labelColor: AppColors.green,
                          indicatorColor: AppColors.green,
                          tabs: <Tab>[
                            TabbarItem(Icons.newspaper, "Tin Đăng"),
                            TabbarItem(Icons.landscape, "Quy Hoạch"),
                          ]),
                      Expanded(
                          child: TabBarView(
                        controller: _tabController,
                        children: [
                          AccountNews(
                              authorId: widget.author!.id, showTitle: true),
                          AccountLand(
                              authorId: widget.author!.id, showTitle: true),
                        ],
                      )),
                    ],
                  ),
                )
              : null),
    );
  }

  Tab TabbarItem(IconData iconData, String label) {
    return Tab(
      icon: Icon(
        iconData,
        color: AppColors.green,
      ),
    );
  }
}
