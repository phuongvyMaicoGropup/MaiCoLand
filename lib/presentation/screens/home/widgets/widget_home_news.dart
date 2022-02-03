import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/home/home_news_bloc/news_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_card_news.dart';

class WidgetHomeNews extends StatelessWidget {
  List<News> items = [];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNewsBloc, HomeNewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          items = state.news;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Tin tức",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: TextButton(
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
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Container(height: 210.0, child: _buildListNews()),
            ],
          );
        } else if (state is NewsNotLoaded) {
          return Container(child: Text("Không load được"));
        } else
          return Container(child: Text("Lỗi"));
      },
    );
  }

  _buildListNews() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length < 6 ? items.length : 5,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
       
        return   WidgetHomeCardNews(
              news: item, 
        );
      },
    );
  }
  void openShowDetails(BuildContext context,News item) {
    Navigator.pushNamed(context, '/news/details', arguments: item);
  }
}