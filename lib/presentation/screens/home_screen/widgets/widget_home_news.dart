import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/widgets/widget_home_card_news.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class WidgetHomeNews extends StatelessWidget {
  List<News> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNewsBloc, HomeNewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
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
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontFamily: "Montserrat",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(height: 200.0, child: _buildListNews()),
              ],
            ),
          );
        } else if (state is NewsNotLoaded) {
          return Container(child: const Text("Không load được"));
        } else {
          return Container(child: const CircularProgressIndicator());
        }
      },
    );
  }

  _buildListNews() {
    return items.isEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
                  child: newSkeleton());
            })
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: items.length < 6 ? items.length : 5,
            itemBuilder: (BuildContext context, int index) {
              var item = items[index];
              return WidgetHomeCardNews(
                news: item,
              );
            },
          );
  }

  Widget newSkeleton() {
    return Container(
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          WidgetSkeleton(height: 105, width: 170),
          SizedBox(height: 8),
          WidgetSkeleton(width: 130, height: 20),
          SizedBox(height: 8),
          WidgetSkeleton(width: 40, height: 20),
        ]));
  }

  void openShowDetails(BuildContext context, News item) {
    Navigator.pushNamed(context, '/news/details', arguments: item);
  }
}
