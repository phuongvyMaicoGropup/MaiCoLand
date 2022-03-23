import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maico_land/helpers/dvhcvn_service.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/valid_chip.dart';

class LandPlanningCard extends StatelessWidget {
  LandPlanningCard({
    Key? key,
    required this.land,
  }) : super(key: key);
  LandPlanning land;

  @override
  Widget build(BuildContext context) {
    // author.photoURL

    return GestureDetector(
      key: UniqueKey(),
      onTap: () => openShowDetails(context, land),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.18,
        // padding: const EdgeInsets.only(top: 8),
        margin: const EdgeInsets.only(bottom: 10, right: 4, left: 4),
        decoration: const BoxDecoration(color: Colors.white,
            // borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 2,
                spreadRadius: 1.1,
              )
            ]),
        child: Row(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, bottom: 5, right: 5),
                      color: Colors.red,
                      child: Text(land.landArea.toString() + " km",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11))))
            ]),
            const SizedBox(width: 10),
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 7,
                      child: Text(
                        land.title,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 15,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                        DvhcvnService.getAddressFromId(land.address.idLevel1,
                            land.address.idLevel2, land.address.idLevel3),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 13)),
                    const SizedBox(height: 5),
                    ValidChip(expirationDate: land.expirationDate),

                    // md.MarkdownBody(data : content,
                    // shrinkWrap : true),
                  ],
                ),
              ),
              Positioned(
                  bottom: 5,
                  right: 10,
                  child: Row(children: [
                    Text(land.likes.length.toString(),
                        style: TextStyle(fontSize: 12, color: AppColors.gray)),
                    Icon(EvaIcons.heart,
                        color: Colors.grey.withOpacity(0.7), size: 17)
                  ])),
            ]),
          ],
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void openShowDetails(BuildContext context, LandPlanning item) {
    Navigator.pushNamed(context, '/landplanning/details', arguments: item);
  }
}
