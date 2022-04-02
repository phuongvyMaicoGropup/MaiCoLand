import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/user_post/user_post_land.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/presentation/widgets/avatar_widget.dart';
import 'package:maico_land/presentation/widgets/widget_skeleton.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({required this.news, Key? key}) : super(key: key);
  final News news;

  final userRepo = UserRepository();
  late User author;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          RepositoryProvider.of<NewsRepository>(context)
              .saveNews(DataLocalInfo(news.title, news.id));
          const snackBar = SnackBar(
            dismissDirection: DismissDirection.up,
            backgroundColor: AppColors.appGreen1,
            content: Text('Đã lưu', style: whiteText),
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: ClipOval(
          child: Container(
              color: AppColors.appGreen1,
              padding: const EdgeInsets.all(5),
              child: const Icon(Icons.save_outlined, color: AppColors.white)),
        ),
      ),
      appBar: AppBar(
        title: const Text("Tin tức chi tiết"),
      ),
      body: FutureBuilder<User?>(
          future: userRepo.getUserById(news.createdBy),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              author = snapshot.data!;
              return ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                children: [
                  Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(news.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    WidgetSkeleton(
                        height: MediaQuery.of(context).size.height * 0.4)
                  ]),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      news.title,
                      style: const TextStyle(
                        color: AppColors.appGreen1,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Ngày đăng : ${news.createDate.day.toString()}/${news.createDate.month.toString()}/${news.createDate.year.toString()}",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Montserrat",
                            fontSize: 11,
                          ),
                    ),
                  ),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: AvatarWidget(name: author.userName),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 7,
                          child: GestureDetector(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    author.email.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    author.phoneNumber.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserPostLand(author: author)));
                            },
                          )),
                      //
                    ],
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Container(
                      child: Text(news.content,
                          style: const TextStyle(height: 1.3))),
                  // const Divider(
                  //   height: 25,
                  //   thickness: 1,
                  // ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
