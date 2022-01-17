import 'package:flutter/material.dart';
import 'package:land_app/model/entity/land_planning.dart';

class LandPlanningCard extends StatelessWidget {
  const LandPlanningCard({ required this.landPlanning , Key? key }) : super(key: key);
  final LandPlanning landPlanning; 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width*0.9 ,
      height:MediaQuery.of(context).size.height*0.18,
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Container(
            width:90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              image: DecorationImage(
                scale : 2.0,
                image: NetworkImage(landPlanning.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: FadeInImage.assetNetwork(
                // fadeInCurve: Curves.bounceIn,
                fadeInDuration: Duration(
                  milliseconds: 500,
                ),
                placeholder: 'assets/images/loading.gif',
                image: landPlanning.imageUrl,
                fit: BoxFit.cover,
                width: 180,
              ),
            ),
          ),
          const SizedBox(width : 10),
          Expanded(
            child: Padding(
              padding: const  EdgeInsets.only(top: 5, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      landPlanning.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(landPlanning.isValidated ? "Tình trạng:  Còn hiệu lực": "Tình trạng: Mất hiệu lực", style : TextStyle(color : Theme.of(context).colorScheme.primary)),
                  const SizedBox(height : 10),
                  Text(
                    "Ngày đăng : ${landPlanning.dateCreated.day}/${landPlanning.dateCreated.month}/${landPlanning.dateCreated.year}",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(

                        fontFamily: "Montserrat",
                        fontSize: 10,
                        fontStyle: FontStyle.italic
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
}