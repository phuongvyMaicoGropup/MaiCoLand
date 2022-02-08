

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchNews(String searchKey){
    return  FirebaseFirestore.instance.collection("news")
    .where('title', isEqualTo: searchKey.substring(0,1).toUpperCase())
    .get();
  }
}