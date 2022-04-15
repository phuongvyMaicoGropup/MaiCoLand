import 'dart:isolate';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/helpers/function_helper.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_top_viewed/bloc/top_news_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/widgets/widget_home_card_news.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class WidgetHomeTopViewedNews extends StatelessWidget {
  List<String> items = [];
  final _newsRepo = NewsRepository();

  WidgetHomeTopViewedNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopNewsBloc, TopNewsState>(
      listener: (context, state) {
        print("bloc home new was build");
      },
      child: BlocBuilder<TopNewsBloc, TopNewsState>(
        // buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is TopNewsLoaded) {
            if (items == []) {
              return Center(child: Text("Không có dữ liệu"));
            }
            items = state.news;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeadingTextWidget(text: "Tin tức nổi bật "),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/news");
                        },
                        child: Text(
                          "Xem thêm",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                fontFamily: "Montserrat",
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length < 3 ? items.length : 3,
                      itemBuilder: (context, index) => FutureBuilder<News>(
                          future: RepositoryProvider.of<NewsRepository>(context)
                              .getNewsById(items[index]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SmallNewsCard(snapshot.data!),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: skeleton(context),
                            );
                          }))
                ],
              ),
            );
          } else if (state is NewsNotLoaded) {
            return Container(child: const Text("Không load được"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeadingTextWidget(text: "Tin tức nổi bật "),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/news");
                        },
                        child: Text(
                          "Xem thêm",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                fontFamily: "Montserrat",
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: skeleton(context));
                          })),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget skeleton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          WidgetSkeleton(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.3),
          SizedBox(width: MediaQuery.of(context).size.height * 0.01),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetSkeleton(
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.55),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              WidgetSkeleton(
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.3),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              WidgetSkeleton(
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.4),
            ],
          )
        ]));
  }
}

class SmallNewsCard extends StatelessWidget {
  const SmallNewsCard(this.news, {Key? key}) : super(key: key);

  final News news;
  void openDetails(BuildContext context, News item) async {
    Isolate.spawn(updateNewsViewd, item.id);

    Navigator.pushNamed(context, '/news/details', arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openDetails(context, news),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ],
                ),
                child: AppCachedImage(news.images![0])),
            SizedBox(width: MediaQuery.of(context).size.height * 0.01),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ngày đăng : ${news.createdDate.day}/${news.createdDate.month}/${news.createdDate.year}",
                    textAlign: TextAlign.right,
                    maxLines: 4,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontFamily: "Montserrat", fontSize: 11),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
