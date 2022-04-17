import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/session_repository.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class NewsSaveScreen extends StatefulWidget {
  const NewsSaveScreen({Key? key}) : super(key: key);

  @override
  State<NewsSaveScreen> createState() => _NewsSaveScreenState();
}

class _NewsSaveScreenState extends State<NewsSaveScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Các tin tức đã lưu")),
        body: FutureBuilder<List<DataLocalInfo>?>(
            future: RepositoryProvider.of<NewsRepository>(context).getNews(),
            builder: (context, snapshot) {
              List<DataLocalInfo>? children = [];
              if (snapshot.hasData) {
                children = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: children!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = children![index];
                    return GestureDetector(
                      onTap: () async {
                        print("Saved News wathc");
                        News? n =
                            await RepositoryProvider.of<NewsRepository>(context)
                                .getNewsById(item.id);
                        if (n != null) {
                          Navigator.of(context)
                              .pushNamed("/news/details", arguments: n);
                        }
                      },
                      child: Stack(children: [
                        SavedDataCard(
                          title: item.name,
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    RepositoryProvider.of<SessionRepository>(
                                            context)
                                        .removeNews(item);
                                    print("Removed Saved News");
                                  });
                                },
                                icon: const Icon(Icons.cancel))),
                      ]),
                    );
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
