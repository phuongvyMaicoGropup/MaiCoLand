import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/news/news_bloc_index/news_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/presentation/screens/news/widgets/news_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> items = [];

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
                  // showSearch(context: context, delegate: NewsSearch(items), );
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
        //       return const Expanded(
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     }else return Container();
        //   });
        // }),

        body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('news').orderBy('dateCreated',descending:true).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final news = News(
                    dateCreated: snapshot.data!.docs[index].get('dateCreated').toDate() ,
                    image: snapshot.data!.docs[index].get('imageUrl'),
                    content: snapshot.data!.docs[index].get('content'),
                    authorId: snapshot.data!.docs[index].get('authorId'),
                    title: snapshot.data!.docs[index].get('title'),
                    dateUpdated: snapshot.data!.docs[index].get('dateUpdated').toDate(),);
                  return NewsCard(
          news: news,
        );
                },
              );
            }),
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

// class NewsSearch extends SearchDelegate<News>{

//   NewsSearch(this.news); 
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),onPressed: (){
//           query = "";
//         }),

//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: (){
//         Navigator.of(context).pop();
//       }
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     var news = FirebaseFirestore.instance.collection('news').orderBy('dateCreated',descending:false).snapshots()
//     ;
      
//     return StreamBuilder<List<News>>(
//       stream:news,
//       builder: (context, AsyncSnapshot<List<News>> snapshot){
//         if (!snapshot.hasData){
//           return Center(child : Text("No data"));
//         }
//         final result =  snapshot.data!.where( (a)=>a.title.toLowerCase().contains(query)); 
//         return  ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final news = News(
//                     dateCreated: snapshot.data![index].dateCreated ,
//                     image: snapshot.data![index].image,
//                     content: snapshot.data![index].content,
//                     authorId: snapshot.data![index].authorId,
//                     title: snapshot.data![index].title,
//                     dateUpdated: snapshot.data![index].dateUpdated);
//                   return NewsCard(
//           news: news,
//         );
//                 },
//               );
        

//       }
//     );
//   }

// }