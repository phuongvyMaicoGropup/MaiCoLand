import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:land_app/model/entity/app_user.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/user_repository.dart';

class NewsRepository {
  final List<News> _news;
  final List<News> _homeNews;
  final _userRepo = UserRepository();
  final _newsCollection = FirebaseFirestore.instance
      .collection('news')
      .orderBy('dateCreated', descending: true);
  NewsRepository()
      : _news = [],
        _homeNews = [];
  Future<List<News>> getHomeNews() async {
    _homeNews.clear();
    await _newsCollection
      .limitToLast(5).get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        List<String>? hashTags = doc['hashTags'].toString().split('/').toList();
        // AppUser user = await _userRepo.getUserByUid(doc['authorId']);
        var newNews = News(
          id : doc.id,
          authorId: doc["authorId"],
          title: doc["title"],
          dateCreated: doc["dateCreated"].toDate(),
          content: doc["content"],
          image: doc["imageUrl"],
          dateUpdated: doc["dateUpdated"].toDate(),
          hashTags: hashTags,
          // user: user
        );
        _homeNews.add(newNews);
      }
    });
    _homeNews.sort( (a, b)=> b.dateCreated.compareTo(a.dateCreated) );
    return Future<List<News>>.value(_homeNews);
  }

  Stream<Iterable<News>> get allNewsData {
    return _newsCollection.snapshots().map(_newsListFromSnapshot);
  }

  Iterable<News> _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      List<String>? hashTags = doc['hashTags'].toString().split('/').toList();
      //  AppUser user = await _userRepo.getUserByUid(doc['authorId']);
      return News(
          id : doc.id,
          authorId: doc["authorId"],
          title: doc["title"],
          dateCreated: doc["dateCreated"].toDate(),
          content: doc["content"],
          image: doc["imageUrl"],
          dateUpdated: doc["dateUpdated"].toDate(),
          hashTags: hashTags,
          user: AppUser(
              uid: "",
              email: "email",
              photoURL: "",
              displayName: "Name",
              phoneNumber: ""));
    });
  }

  Future<List<News>> getAll() async {
    _newsCollection.get().then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        List<String>? hashTags = doc['hashTags'].toString().split('/').toList();
        AppUser user = await _userRepo.getUserByUid(doc['authorId']);

        print(doc["title"]);
        var newNews = News(
          id : doc.id,
            authorId: doc["authorId"],
            title: doc["title"],
            dateCreated: doc["dateCreated"].toDate(),
            content: doc["content"],
            image: doc["imageUrl"],
            dateUpdated: doc["dateUpdated"].toDate(),
            hashTags: hashTags,
            user: user);
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
