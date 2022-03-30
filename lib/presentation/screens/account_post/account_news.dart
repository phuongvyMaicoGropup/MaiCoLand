import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/screens/news/widgets/news_card.dart';

class AccountNews extends StatefulWidget {
  AccountNews({required this.authorId, this.showTitle, Key? key})
      : super(key: key);
  final String authorId;
  bool? showTitle;
  @override
  _AccountNewsState createState() => _AccountNewsState();
}

class _AccountNewsState extends State<AccountNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.showTitle == null
            ? AppBar(title: const Text("Tin tức của tôi"))
            : null,
        body: FutureBuilder<List<News>?>(
            future: RepositoryProvider.of<NewsRepository>(context)
                .getNewsByAuthorId(widget.authorId),
            builder: (context, snapshot) {
              List<News>? children = [];
              if (snapshot.hasData) {
                children = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: children!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = children![index];
                    return GestureDetector(
                        onTap: () async {
                          Navigator.of(context)
                              .pushNamed("/news/details", arguments: item);
                        },
                        child: NewsCard(
                          news: item,
                        ));
                  },
                );
              } else if (snapshot.hasError) {
                return const Text("Đã xảy ra lỗi ");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
