import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/presentation/widgets/cached_image.dart';
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
        width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: news.imageUrl,
                  fadeInDuration: const Duration(microseconds: 0),
                  fadeOutDuration: const Duration(microseconds: 0),
                  placeholder: (_, __) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 7,
                      child: Text(
                        news.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Montserrat",
                              fontSize: 16,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Ngày đăng : ${news.createDate.day}/${news.createDate.month}/${news.createDate.year}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontFamily: "Montserrat",
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                    // md.MarkdownBody(data : content,
                    // shrinkWrap : true),
                  ],
                ),
              ),
            ],
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

  void openShowDetails(BuildContext context, News item) {
    Navigator.pushNamed(context, '/news/details', arguments: item);
  }
}
