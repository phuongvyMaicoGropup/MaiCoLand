import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/screens/news/widgets/news_card.dart';

class AccountNews extends StatefulWidget {
  const AccountNews({
    required this.authorId,Key? key}) : super(key: key);
  final String authorId;
  @override
  _AccountNewsState createState() => _AccountNewsState();
}

class _AccountNewsState extends State<AccountNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Tin tức của tôi")),
        body: FutureBuilder<List<News>?>(
            future: RepositoryProvider.of<NewsRepository>(context).getNewsByAuthorId(widget.authorId),
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
                      child: NewsCard(news: item,)
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
