import 'package:land_app/model/entity/land_planning.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
class PlanningLandRepository{
    List<LandPlanning> _landPlannings;
    PlanningLandRepository() : _landPlannings =[]; 
    Future<List<LandPlanning>> getAll()async{
       await FirebaseFirestore.instance.collection('landplannings').get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
           print(doc["title"]);
            var newLand = LandPlanning(
              id : doc.id,
              accessToken: doc["accessToken"],
              title: doc["title"],
              dateCreated: doc["dateCreated"].toDate(),
              leftBottom: LatLng(doc["leftBottom"].latitude, doc["leftBottom"].longitude) ,
              rightBottom: LatLng(doc["rightBottom"].latitude, doc["rightBottom"].longitude),
              leftTop: LatLng(doc["leftTop"].latitude, doc["leftTop"].longitude),
              rightTop: LatLng( doc["rightTop"].latitude,  doc["rightTop"].longitude),
              content : doc["content"],
              isValidated: doc["isValidated"],
              imageUrl: doc["imageUrl"],
              mapUrl : doc["mapUrl"],
              ); 
            _landPlannings.add(newLand);
        });
    }); 
    print(_landPlannings[0].content); 
    return Future<List<LandPlanning>>.value(_landPlannings);
    }
}