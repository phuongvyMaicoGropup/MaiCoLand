import 'package:flutter/material.dart';
import 'package:maico_land/presentation/screens/account_post/account_land.dart';
import 'package:maico_land/presentation/screens/account_post/account_news.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class UserPostLand extends StatefulWidget {
  UserPostLand({Key? key, this.authorId}) : super(key: key);
  String? authorId;
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
