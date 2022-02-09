import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:land_app/model/entity/news.dart';
class NewsRepository{
    final List<News> _news;
    final List<News> _homeNews; 
    NewsRepository() : _news =[] , _homeNews =[]; 
    Future<List<News>> getHomeNews()async{
      _homeNews.clear();
       await FirebaseFirestore.instance
       .collection('news')
       .orderBy('dateCreated', descending: false)
       .limitToLast(5)
       .get()
    .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
                  List<String>? hashTags = doc['hashTags'].toString().split('/').toList();

            var newNews = News(
              authorId: doc["authorId"],
              title: doc["title"],
              dateCreated: doc["dateCreated"].toDate(),
              content : doc["content"],
              image: doc["imageUrl"],
              dateUpdated:  doc["dateUpdated"].toDate(),
              hashTags: hashTags
              ); 
            _homeNews.add(newNews);
        }
    }); 
   
    return Future<List<News>>.value(_homeNews);
    }
    CollectionReference<News> news =  FirebaseFirestore.instance.collection('news').withConverter<News>(
      fromFirestore: (snapshot, _) => News.fromMap(snapshot.data()!),
      toFirestore: (News, _) => News.toMap(),
    );
    Future<List<News>> getAll()async{

      _news.clear();
       await FirebaseFirestore.instance
       .collection('news')
       .orderBy('dateCreated', descending: true)
       .limitToLast(20)
       .get()
    .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
           List<String>? hashTags = doc['hashTags'].toString().split('/').toList();
           print(doc["title"]);
            var newNews = News(
              authorId: doc["authorId"],
              title: doc["title"],
              dateCreated: doc["dateCreated"].toDate(),
              content : doc["content"],
              image: doc["imageUrl"],
              dateUpdated:  doc["dateUpdated"].toDate(),
              hashTags : hashTags
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