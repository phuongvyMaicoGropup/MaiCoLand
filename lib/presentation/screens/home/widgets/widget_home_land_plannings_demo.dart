import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_card_land_plannings.dart';
import 'package:land_app/presentation/screens/land_plannings/land_planning_details/land_planning_details_screen.dart';
import 'package:latlong2/latlong.dart';
class WidgetHomeLandPlanning extends StatefulWidget {
  final String title;
  final String collectionName;
  final List<LandPlanning> landPlannings; 
  const WidgetHomeLandPlanning({
    Key? key,
    required this.title,
    required this.collectionName,
    required this.landPlannings,
  }) : super(key: key);
  @override
  _WidgetHomeLandPlanningState createState() => _WidgetHomeLandPlanningState();
}

class _WidgetHomeLandPlanningState extends State<WidgetHomeLandPlanning> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const LandPlanningPage(),
                  //   ),
                  // );
                },
                child: Text(
                  "Xem thêm",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontFamily: "Montserrat",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 210.0,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection(widget.collectionName).snapshots(),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                if (snapshot.hasError) {
                  return Text("something is wrong", style: TextStyle(color : Theme.of(context).colorScheme.error),);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length < 6 ? snapshot.data!.docs.length : 5 ,
                    itemBuilder: (BuildContext context, int index) {
                      final LandPlanning landPlanning = LandPlanning(
                        id : snapshot.data!.docs[index].id,
                          title:  snapshot.data!.docs[index].get('title'),
                          content: snapshot.data!.docs[index].get('content'),
                          dateCreated: snapshot.data!.docs[index].get('dateCreated').toDate(),
                          accessToken: snapshot.data!.docs[index].get('accessToken'),
                          isValidated: snapshot.data!.docs[index].get('isValidated'),
                          mapUrl: snapshot.data!.docs[index].get('mapUrl'),
                          imageUrl: snapshot.data!.docs[index].get('imageUrl'),
                          leftTop:  LatLng(snapshot.data!.docs[index].get('leftTop').latitude, snapshot.data!.docs[index].get('leftTop').longitude),
                          rightTop:  LatLng(snapshot.data!.docs[index].get('rightTop').latitude, snapshot.data!.docs[index].get('rightTop').longitude),
                          leftBottom:  LatLng(snapshot.data!.docs[index].get('leftBottom').latitude, snapshot.data!.docs[index].get('leftBottom').longitude),
                          rightBottom:  LatLng(snapshot.data!.docs[index].get('rightBottom').latitude, snapshot.data!.docs[index].get('rightBottom').longitude),
                      );
                      return GestureDetector(
                        onTap: ()=> 

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMapLandPlanning(landPlanning: landPlanning,))),
                        child: WidgetHomeCardLandPlanning(
                          landPlanning: landPlanning,
                        ),
                      );
                    },
                  );
              }),
        ),
      ],
    );
  }
}
