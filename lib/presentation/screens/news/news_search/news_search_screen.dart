import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:land_app/helpers/searchService.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/entity/search_key.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({Key? key}) : super(key: key);

  @override
  State<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {

  var queryResultSet =[];
  var tempSearchStore = [];

  initialSearch(value){
    if(value.length == 0 ){
      setState((){
        queryResultSet =[];
tempSearchStore = [];
      });
    }
    var capitializedValue = value.substring(0,1).toUpperCase() + value.substring(1 );
    print(_newsSearchKey.text);
     SearchService().searchNews(value).then((QuerySnapshot docs){
        for (int i = 0 ; i< docs.docs.length ; ++i){
          queryResultSet.add(docs.docs[i].data);
          print(docs.docs[i].data);
        }
      });
    if(queryResultSet.length == 0 ){
      SearchService().searchNews(value).then((QuerySnapshot docs){
        for (int i = 0 ; i< docs.docs.length ; ++i){
          queryResultSet.add(docs.docs[i].data);
          print(docs.docs[i].data);
        }
      });
    }else{
      print("meo");
      tempSearchStore = [];
      for (var element in queryResultSet) {
        if (element['title'].startWith(capitializedValue)){
          setState((){
            tempSearchStore.add(element);
          });
        }
      }
    }
  }
  final _newsSearchKey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _newsSearchKey,
              onChanged: (value) {
                initialSearch(value);
                print("he");
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _newsSearchKey.text = "";
                    },
                  ),
                  hintText: 'Tìm kiếm tin tức',
                  border: InputBorder.none),
            ),
          ),
        )),
        body: _buildListSuggestion());
  }

  Widget _buildListSuggestion() {
    return  ListView.builder(
          itemCount: tempSearchStore.length,
          itemBuilder: (context, index) =>
              _buildListItem(tempSearchStore[index]),
        );
  }

  Widget _buildListItem(DocumentSnapshot document) {
    return ListTile(
      title: document['title'],
      subtitle: document['title'],
    );
  }
}
