import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/news/news_bloc_index/news_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/presentation/screens/news/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> items = [];
  bool _isSearch = false;
 

  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
    //  BlocProvider.of<NewsBloc>(context)
    //         .add(NewsInitial());
      return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if (state is NewsLoaded) {
          items = state.news;
          return SafeArea(
              child: Scaffold(
                  appBar: AppBar(title: const Text("Tin tức"),
                  actions: [
_isSearch == true
                        ? 
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search Flutter Topic",
                                  hintStyle: TextStyle(
                                    color: Colors.black.withAlpha(120),
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (String keyword) {},
                              ),
                            )
                            // Icon(
                            //   Icons.search,
                            //   color: Colors.black.withAlpha(120),
                            // )
                          
                        : Container(),
                      IconButton(
                      onPressed: () {
                        if (_isSearch == true) {
                          setState(() {
                            print("year");
                            _isSearch = false;
                          });
                        } else {
                          setState(() {
                            _isSearch = true;
                          });
                        }
                      },
                      icon: Icon(Icons.search),
                                        ),
                        

                    
                  ]),
                  body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RefreshIndicator(
                        onRefresh: () async {
            BlocProvider.of<NewsBloc>(context).add(NewsRefresh());
            BlocProvider.of<NewsBloc>(context).add(NewsLoad());
          },
                        child : _buildListNews()
                      ) )));
        } else if (state is NewsNotLoaded) {
          return Container(child: Text("Không load được"));
        } else if (state is NewsLoading){
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }else return Container();
      });
    });
  }

  _buildListNews() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return NewsCard(
          news: item,
        );
      },
    );
  }
}
