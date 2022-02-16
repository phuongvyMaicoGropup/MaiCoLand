import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/news_repository.dart';
import 'package:land_app/model/repository/user_repository.dart';
import 'package:land_app/presentation/resources/resources.dart';
import 'package:land_app/presentation/screens/news/widgets/news_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> items = [];
  final _userRepo = UserRepository();
  final _newsRepo = NewsRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tin tức'),
          centerTitle: true,
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed("/news/search");
                  showSearch(
                    context: context,
                    delegate: NewsSearch(_newsRepo.allNewsData),
                  );
                },
                icon: Icon(Icons.search))
          ],
        ),

        // body:Builder(builder: (context) {

        //  BlocProvider.of<NewsBloc>(context).add(NewsLoad());
        //   return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        //     if (state is NewsLoaded) {
        //       items = state.news;
        //       return Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: RefreshIndicator(
        //                 onRefresh: () async {
        //         BlocProvider.of<NewsBloc>(context).add(NewsRefresh());
        //         BlocProvider.of<NewsBloc>(context).add(NewsLoad());
        //       },
        //                 child :_buildListNews()
        //               ) );

        //     } else if (state is NewsNotLoaded) {
        //       return Container(child: Text("Không load được"));
        //     } else if (state is NewsLoading){
        //       return const Center(
        //         child: Expanded(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     }else return const Expanded(
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ));
        //   });
        // }),

        body: Container(
          color: AppColors.gray.withAlpha(30),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: StreamBuilder<Iterable<News>>(
                stream: _newsRepo.allNewsData,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("hello" + snapshot.error.toString());
                    return Text("something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var news = snapshot.data!.elementAt(index);

                      return NewsCard(
                        news: news,
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
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

class NewsSearch extends SearchDelegate<News> {
  final Stream<Iterable<News>> news;
  NewsSearch(this.news);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
   return StreamBuilder<Iterable<News>>(
        stream: news,
        builder: (context, AsyncSnapshot<Iterable<News>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No data"));
          }
          final result = snapshot.data!
              .where((a) => a.title.toLowerCase().contains(query.toLowerCase()));
              
          return ListView(
              children: result
                  .map((a) => NewsCard(news: a))
                  // ListTile(
                  //     title: Text(a.title),
                  //     leading: const Icon(Icons.search),
                  //     onTap: () {                       
                  //       close(context,a);
                  //     }
                  //     // subtitle: Text(a.)
                  //     ))
                  .toList());
         
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<Iterable<News>>(
        stream: news,
        builder: (context, AsyncSnapshot<Iterable<News>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No data"));
          }
          final result = snapshot.data!
              .where((a) => a.title.toLowerCase().contains(query.toLowerCase()));
          return ListView(
              children: result
                  .map((a) => NewsCard(news: a))
                  // ListTile(
                  //     title: Text(a.title, style : const TextStyle(color: Colors.grey)),
              
                  //     onTap: () {
                  //       // query = a.title;
                  //        close(context,a);
                  //     }
                  //     // subtitle: Text(a.)
                  //     ))
                  .toList());
         
        });
  }
}
