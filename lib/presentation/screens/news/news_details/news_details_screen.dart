import 'dart:isolate';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({required this.news, Key? key}) : super(key: key);
  final News news;

  final userRepo = UserRepository();
  late User author;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tin tức chi tiết"), actions: [
        IconButton(
            icon: const Icon(EvaIcons.heart, color: AppColors.white),
            onPressed: () async {
              var result = RepositoryProvider.of<NewsRepository>(context)
                  .likeNews(news.id);
              print(result);
            }),
        const SizedBox(width: 10)
      ]),
      body: FutureBuilder<User>(
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
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              shape: BoxShape.circle,
                              image: author.photoURL.toString() != ""
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          author.photoURL.toString()))
                                  : const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/default_avatar.png"))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 7,
                        child: Column(children: [
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
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                      ),
                      //
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(child: Text(news.content)),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
