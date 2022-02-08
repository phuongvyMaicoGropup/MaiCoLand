import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_state.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_event.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_card_land_plannings.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_land_plannings.dart';
import 'package:land_app/presentation/screens/land_plannings/land_planning_details/land_planning_details_screen.dart';
import 'package:land_app/presentation/screens/land_plannings/widgets/land_planning_card.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/src/provider.dart';

class LandPlanningsScreen extends StatefulWidget {
  const LandPlanningsScreen({Key? key}) : super(key: key);

  @override
  _LandPlanningsScreenState createState() => _LandPlanningsScreenState();
}

class _LandPlanningsScreenState extends State<LandPlanningsScreen> {
  List<LandPlanning> items = [];
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quy hoạch'),
          centerTitle: true,
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed("/landPlanning/search");
                  // showSearch(context: context, delegate: landPlanningSearch(items), );
                },
                icon: Icon(Icons.search))
          ],
        ),
        
          
        // body:Builder(builder: (context) {

        //  BlocProvider.of<landPlanningBloc>(context).add(landPlanningLoad());
        //   return BlocBuilder<landPlanningBloc, landPlanningState>(builder: (context, state) {
        //     if (state is landPlanningLoaded) {
        //       items = state.landPlanning;
        //       return Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: RefreshIndicator(
        //                 onRefresh: () async {
        //         BlocProvider.of<landPlanningBloc>(context).add(landPlanningRefresh());
        //         BlocProvider.of<landPlanningBloc>(context).add(landPlanningLoad());
        //       },
        //                 child :_buildListlandPlanning()
        //               ) );     
                          
                        
            
        //     } else if (state is landPlanningNotLoaded) {
        //       return Container(child: Text("Không load được"));
        //     } else if (state is landPlanningLoading){
        //       return const Expanded(
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     }else return Container();
        //   });
        // }),

        body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('landplannings').orderBy('dateCreated',descending:true).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print("hello" + snapshot.error.toString());
                return Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = LandPlanning(
              id :  snapshot.data!.docs[index].id,
              accessToken:  snapshot.data!.docs[index].get("accessToken"),
              title:  snapshot.data!.docs[index].get("title"),
              dateCreated:  snapshot.data!.docs[index].get("dateCreated").toDate(),
              leftBottom: LatLng( snapshot.data!.docs[index].get("leftBottom").latitude,  snapshot.data!.docs[index].get("leftBottom").longitude) ,
              rightBottom: LatLng( snapshot.data!.docs[index].get("rightBottom").latitude,  snapshot.data!.docs[index].get("rightBottom").longitude),
              leftTop: LatLng( snapshot.data!.docs[index].get("leftTop").latitude,  snapshot.data!.docs[index].get("leftTop").longitude),
              rightTop: LatLng(  snapshot.data!.docs[index].get("rightTop").latitude,   snapshot.data!.docs[index].get("rightTop").longitude),
              content :  snapshot.data!.docs[index].get("content"),
              isValidated:  snapshot.data!.docs[index].get("isValidated"),
              imageUrl:  snapshot.data!.docs[index].get("imageUrl"),
              mapUrl :  snapshot.data!.docs[index].get("mapUrl"),
              ); 
                  return  GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailMapLandPlanning(
                        landPlanning: item,
                      ))),
          child: LandPlanningCard(
            landPlanning: item,
          ),
        );
                },
              );
            }),
      ), 
      
      ),
    );
 
  }

  _buildListLandPlanning() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
    shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailMapLandPlanning(
                        landPlanning: item,
                      ))),
          child: LandPlanningCard(
            landPlanning: item,
          ),
        );
      },
    );
  }
}
