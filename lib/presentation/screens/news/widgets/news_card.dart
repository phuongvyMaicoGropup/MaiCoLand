import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:land_app/model/entity/app_user.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/model/repository/user_repository.dart';
import 'package:land_app/presentation/resources/resources.dart';
class NewsCard extends StatelessWidget {
   NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);
  News news;
  
  final  _userRepo = UserRepository();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openShowDetails(context, news),
      child:  Stack(
        children:[
           Container(
          padding: const EdgeInsets.all(10),
        // width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.14,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            
            
            ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                width:  MediaQuery.of(context).size.width*0.25,
                height:  MediaQuery.of(context).size.height*0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    // fadeInCurve: Curves.bounceIn,
                    fadeInDuration: const Duration(
                      milliseconds: 500,
                    ),
                    placeholder: 'assets/images/loading.gif',
                    image: news.image,
                    fit: BoxFit.cover,
                    width: 180,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(
                // width:  MediaQuery.of(context).size.width*0.45,
                padding: const EdgeInsets.only( left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  <Widget>[
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    //     Flexible(
                    //       flex: 3, 
                    //       child: CircleAvatar(
                    //         backgroundImage:
                    //          news.user!.photoURL.toString()==""
                    //             ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2Fnews_default_image.png?alt=media&token=c18a786d-edc2-42f7-bf06-878906c85320") :
                    //         NetworkImage(news.user!.photoURL.toString()),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Flexible(
                    //       flex: 7,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //             Text(
                    //               news.user!.displayName.toString(),
                    //               maxLines: 1, 
                    //               overflow: TextOverflow.fade,
                    //                softWrap: false,
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .caption
                    //                   ?.copyWith(
                    //                 fontWeight: FontWeight.w600,
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: 16,
                    //               ),
                    //             ),
                                                         
                    //           Text(
                    //             news.user!.phoneNumber.toString(),
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyText2
                    //                 ?.copyWith(
                    //               fontWeight: FontWeight.w500,
                    //               fontFamily: "Montserrat",
                    //               fontSize: 12,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
            
                    Flexible(
                      flex: 2,
                      child: Text(
                        news.title, 
                        textAlign:TextAlign.justify, 
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          fontSize: 16,
                        ),
                      ),
                    ),
           
                    // const SizedBox(height: 5),
                    // Text(
                    //   "Ngày đăng : ${news.dateCreated.day}/${news.dateCreated.month}/${news.dateCreated.year}",
                    //   textAlign: TextAlign.right,
                    //   style: Theme.of(context).textTheme.bodyText2?.copyWith(
            
                    //       fontFamily: "Montserrat",
                    //       fontSize: 10,
                    //       fontStyle: FontStyle.italic
                    //   ),
                    // ),
                  
            
                  ],
                ),
              ),
            ),
                 
          
             
             ],
        ),
          ),
                   Positioned(
              right: 8,
              bottom: 10,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.timer, color: AppColors.gray,),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    (daysBetween(news.dateCreated,DateTime.now())==0)? "Hôm nay":daysBetween(news.dateCreated,DateTime.now()).toString()+ " ngày",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color:  AppColors.gray,
                      fontFamily: "Montserrat",
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ]
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

   void openShowDetails(BuildContext context,News item) {
    Navigator.pushNamed(context, '/news/details', arguments: item);
  }
}