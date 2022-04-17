import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/user_post/user_post_land.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/presentation/widgets/avatar_widget.dart';
import 'package:maico_land/presentation/widgets/widget_skeleton.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({required this.news, Key? key}) : super(key: key);
  final News news;
  final userRepo = UserRepository();
  late User author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Tin tức chi tiết"),
      // ),
      body: FutureBuilder<User?>(
          future: userRepo.getUserById(news.createdBy),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              author = snapshot.data!;
              // return PageSkeleton();
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    leading: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.chevron_left)),
                    actions: [
                      MoreOption(news.title, news.id),
                      // IconButton(
                      //     onPressed: () {}, icon: const Icon(Icons.more_vert))
                    ],
                    title: Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AvatarWidget(name: author.userName),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            flex: 7,
                            child: GestureDetector(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      author.userName.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserPostLand(author: author)));
                              },
                            )),
                        //
                      ],
                    ),
                    // expandedHeight: ,
                    // flexibleSpace:
                    //     FlexibleSpaceBar(title: Text("Basic Sliver"))
                  ),
                  SliverToBoxAdapter(
                    child: CarouselSlider(
                        items: news.images!
                            .map((e) => Container(
                                child: Image.network(e, fit: BoxFit.cover)))
                            .toList(),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.3,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          // onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(children: [
                          Text(news.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.black)),
                          Row(children: [
                            Text(author.userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black)),
                            Text(
                                " ${news.createdDate.day}/${news.createdDate.month}/${news.createdDate.year}",
                                style: TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.4))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          ])
                        ]),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(news.content,
                            style: const TextStyle(height: 1.3))),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text("Đã xảy ra lỗi. Quay lại trang chủ!"));
            } else {
              return const Center(child: PageSkeleton());
            }
          }),
    );
  }
}

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          WidgetSkeleton(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CircleAvatar(
              radius: 18,
              //  radius : Radius.circular(10.0),
              backgroundColor: Colors.black.withOpacity(0.05),
              // child: WidgetSkeleton(
              //     width: MediaQuery.of(context).size.width * 0.1,
              //     height: MediaQuery.of(context).size.height * 0.05),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            WidgetSkeleton(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.04),
          ]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          WidgetSkeleton(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          WidgetSkeleton(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          WidgetSkeleton(
              width: MediaQuery.of(context).size.width * 0.86,
              height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          WidgetSkeleton(
              width: MediaQuery.of(context).size.width * 0.94,
              height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          WidgetSkeleton(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader(this.author, this.content,
      {required this.minExtent, required this.maxExtent});

  final double minExtent;
  final double maxExtent;
  final String content;
  final User author;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: AvatarWidget(name: author.userName),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                flex: 7,
                child: GestureDetector(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author.email.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          author.phoneNumber.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserPostLand(author: author)));
                  },
                )),
            //
          ],
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;
  @override
  TickerProvider? get vsync => null;
}

class MoreOption extends StatelessWidget {
  const MoreOption(this.title, this.id, {Key? key}) : super(key: key);
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_horiz_outlined),
      onPressed: () {
        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.05,
              // color: Colors.amber,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          RepositoryProvider.of<NewsRepository>(context)
                              .saveNews(DataLocalInfo(title, id));
                          const snackBar = SnackBar(
                            dismissDirection: DismissDirection.up,
                            backgroundColor: AppColors.appGreen1,
                            content: Text('Đã lưu', style: whiteText),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text("Lưu tin ",
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
