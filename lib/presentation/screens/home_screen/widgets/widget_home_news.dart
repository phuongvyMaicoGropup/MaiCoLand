import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/widgets/widget_home_card_news.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class WidgetHomeNews extends StatelessWidget {
  List<String> items = [];
  final _newsRepo = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeNewsBloc, HomeNewsState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        print("bloc home new was build");
      },
      child: BlocBuilder<HomeNewsBloc, HomeNewsState>(
        // buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is HomeNewsLoaded) {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const HeadingTextWidget(text: "Tin tức"),
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
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                      height: 200.0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: items
                              .map((a) => FutureBuilder<News>(
                                  future: RepositoryProvider.of<NewsRepository>(
                                          context)
                                      .getNewsById(a),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return WidgetHomeCardNews(
                                          news: snapshot.data!);
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: newSkeleton(context),
                                      );
                                    }
                                  }))
                              .toList(),
                        ),
                      )),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const HeadingTextWidget(text: "Tin tức"),
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
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.all(8),
                                child: newSkeleton(context));
                          })),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget newSkeleton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          WidgetSkeleton(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.7),
          SizedBox(height: 8),
          WidgetSkeleton(
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.width * 0.3),
          SizedBox(height: 8),
          WidgetSkeleton(
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.width * 0.5),
        ]));
  }

  Future openShowDetails(BuildContext context, News item) async {
    bool result = await _newsRepo.likeNews(item.id);
    print("Update viewed in news result : " + result.toString());
    Navigator.pushNamed(context, '/news/details', arguments: item);
  }
}
