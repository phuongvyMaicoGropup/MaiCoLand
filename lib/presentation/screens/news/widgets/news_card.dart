import 'dart:isolate';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maico_land/helpers/function_helper.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/widgets/cached_image.dart';
import 'package:maico_land/presentation/widgets/text_icon.dart';
import 'package:maico_land/presentation/widgets/type_news_chip.dart';

class NewsCard extends StatelessWidget {
  NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);
  News news;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openShowDetails(context, news),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 5,
                spreadRadius: 1.1,
              )
            ]),
        child: Stack(children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.38,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: news.images![0],
                  fadeInDuration: const Duration(microseconds: 0),
                  fadeOutDuration: const Duration(microseconds: 0),
                  placeholder: (_, __) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Ngày đăng : ${news.createdDate.day}/${news.createdDate.month}/${news.createdDate.year}",
                      textAlign: TextAlign.right,
                      maxLines: 4,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontFamily: "Montserrat", fontSize: 11),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      news.content,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                          ),
                    ),

                    // md.MarkdownBody(data : content,
                    // shrinkWrap : true),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextIcon(EvaIcons.eye, news.viewed.toString()),
                    TextIcon(EvaIcons.save, news.saved.toString()),
                  ]),
            ),
          ),
          Positioned(
            child: TypeNewsChip(type: news.type),
          ),
        ]),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void openShowDetails(BuildContext context, News item) async {
    Isolate.spawn(updateNewsViewd, item.id);

    Navigator.pushNamed(context, '/news/details', arguments: item);
  }
}
