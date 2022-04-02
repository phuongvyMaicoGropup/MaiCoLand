import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:maico_land/model/entities/user.dart';
=======
>>>>>>> update tieppp
import 'package:maico_land/presentation/screens/account_post/account_land.dart';
import 'package:maico_land/presentation/screens/account_post/account_news.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class UserPostLand extends StatefulWidget {
<<<<<<< HEAD
  UserPostLand({Key? key, this.author}) : super(key: key);
  User? author;
=======
  UserPostLand({Key? key, this.authorId}) : super(key: key);
  String? authorId;
>>>>>>> update tieppp
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
<<<<<<< HEAD
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: const Text('Tác giả'),
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
                                    const EdgeInsets.only(top: 50, bottom: 15),
                                child: widget.author!.photoURL == ""
                                    ? CircleAvatar(
                                        backgroundColor: AppColors.appGreen1,
                                        child: Text(
                                          widget.author!.lastName[0],
                                          style: textMediumWhite,
                                        ),
                                        radius: 50,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            widget.author!.photoURL),
                                        radius: 50,
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
                                widget.author!.firstName +
                                    " " +
                                    widget.author!.lastName,
                                style: textLargeGreen,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                " Liên hệ ",
                                style: textMiniBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " Số điện thoại: " + widget.author!.phoneNumber,
                                style: textMiniBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " Email: " + widget.author!.email,
                                style: textMiniBlack,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              " Bài viết liên quan ",
                              style: textMediumBlack,
                            ),
                          ),
                        ],
                      ),
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
=======
        backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          title: const Text('Tin đăng và bài viết quy hoạch'),
          centerTitle: true,
        ),
        body: widget.authorId != null
            ? Column(
                children: <Widget>[
                  TabBar(
                      controller: _tabController,
                      labelColor: AppColors.green,
                      indicatorColor: AppColors.green,
                      tabs: <Tab>[
                        TabbarItem(Icons.landscape, "Quy Hoạch"),
                        TabbarItem(Icons.newspaper, "Tin Đăng"),
                      ]),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      AccountLand(authorId: widget.authorId!, showTitle: true),
                      AccountNews(authorId: widget.authorId!, showTitle: true),
                    ],
                  )),
                ],
              )
            : null);
>>>>>>> update tieppp
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
