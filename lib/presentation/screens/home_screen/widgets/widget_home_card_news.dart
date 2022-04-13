import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/widgets/text_icon.dart';

class WidgetHomeCardNews extends StatelessWidget {
  WidgetHomeCardNews({Key? key, required this.news}) : super(key: key);

  News news;
  void openNewsDetails(BuildContext context, News item) async {
    bool result = await NewsRepository().updateViewed(item.id);
    print("Update viewed in news result : " + result.toString());
    Navigator.pushNamed(context, '/news/details', arguments: item);
  }

  final DioProvider _dioProvider = DioProvider();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openNewsDetails(context, news),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                // borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(news.images![0]),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ngày đăng : ${news.createdDate.day}/${news.createdDate.month}/${news.createdDate.year}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontFamily: "Montserrat",
                                          fontSize: 9,
                                          fontStyle: FontStyle.italic),
                                ),
                              ]),
                          const SizedBox(height: 5),
                          Container(
                            child: Text(
                              news.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                  ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextIcon(EvaIcons.eye, news.viewed.toString()),
                                TextIcon(EvaIcons.save, news.saved.toString()),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 2,
                left: 5,
                right: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset('assets/icons/fire.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    (daysBetween(news.createdDate, DateTime.now()) == 0)
                        ? "Hôm nay"
                        : daysBetween(news.createdDate, DateTime.now())
                                .toString() +
                            " ngày trước",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
