import 'package:flutter/material.dart';
import 'package:land_app/model/entity/news.dart';

class NewsSearch extends SearchDelegate<String>{
  final newsTitle = [
    "mêm",
    "hạnh phúc",
    "làm gì",
    "ales",
    "BÊBEE",
    "alest",
    "mana"
  ];
  final recentNews = [
     "BÊBEE",
    "alest",
    "mana"
  ];
  String selectedResult="";
   List<String> listExample = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query ="";
        }
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pop(context);
      }
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child : Text(selectedResult)
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); 
  }
  
}