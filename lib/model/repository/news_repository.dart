import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:land_app/model/entity/news.dart';
class NewsRepository{
    final List<News> _news;
    NewsRepository() : _news =[]; 
    Future<List<News>> getHomeNews()async{
       await FirebaseFirestore.instance
       .collection('news')
       .orderBy('dateCreated', descending: true)
       .limitToLast(5)
       .get()
    .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
           print(doc["title"]);
            var newNews = News(
              id : doc.id,
              authorId: doc["authorId"],
              title: doc["title"],
              dateCreated: doc["dateCreated"].toDate(),
              content : doc["content"],
              image: doc["imageUrl"],
              dateUpdated:  doc["dateUpdated"].toDate(),
              hashTags: doc["hashTags"]
              ); 
            _news.add(newNews);
        }
    }); 
    print(_news[0].content); 
    return Future<List<News>>.value(_news);
    }
    Future<List<News>> getAll()async{
       await FirebaseFirestore.instance
       .collection('news')
       .orderBy('dateCreated', descending: true)
       .limitToLast(20)
       .get()
    .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
           print(doc["title"]);
            var newNews = News(
              id : doc.id,
              authorId: doc["authorId"],
              title: doc["title"],
              dateCreated: doc["dateCreated"].toDate(),
              content : doc["content"],
              image: doc["imageUrl"],
              dateUpdated:  doc["dateUpdated"].toDate(),
              hashTags : doc["hashTags"]
              ); 
            _news.add(newNews);
        }
    }); 
    print(_news[0].content); 
    return Future<List<News>>.value(_news);
    }

    // Future<List<String>> getAllTitle() async{
    //   List<String> list = []; 
    //    for (var element in _news) {list.add(element.title);}
    //    return list; 
    // }
}