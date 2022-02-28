// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:land_app/model/entity/app_user.dart';
// import 'package:land_app/model/entity/news.dart';
// import 'package:land_app/model/repository/authentication_repository.dart';
// import 'package:land_app/model/repository/user_repository.dart';
// class NewsCard extends StatefulWidget {
//    NewsCard({
//     Key? key,
//     required this.news,
//   }) : super(key: key);
//   News news;

//   @override
//   State<NewsCard> createState() => _NewsCardState();
// }

// class _NewsCardState extends State<NewsCard> {
//   final  _userRepo = UserRepository();
//   AppUser author =AppUser(uid : "", displayName: "",email: "", phoneNumber: "",photoURL : ""); 
//   // getAuthorInfo()async {
//   //   setState(()async{

//   //   author = await _userRepo.getUserByUid(widget.news.authorId);
//   //   });
//   // }
  
//   @override
//   Widget build(BuildContext context) {
//     // author.photoURL
//     // getAuthorInfo();
//     User author = RepositoryProvider.of<AuthenticationRepository>(context).user;
//     return GestureDetector(
//       onTap: () => openShowDetails(context, widget.news),
//       child:  Container(
//       width: MediaQuery.of(context).size.width*0.9,
//       height: MediaQuery.of(context).size.height*0.18,
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(2, 2),
//               blurRadius: 5,
//               spreadRadius: 1.1,
//             )
//           ]),
//       child: Row(
//         children: [
//           Container(
//             width:  MediaQuery.of(context).size.width*0.45,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(5),
//                 bottomLeft: Radius.circular(5),
//               ),
//               image: DecorationImage(
//                 image: NetworkImage(widget.news.image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(5),
//                 topRight: Radius.circular(5),
//               ),
//               child: FadeInImage.assetNetwork(
//                 // fadeInCurve: Curves.bounceIn,
//                 fadeInDuration: const Duration(
//                   milliseconds: 500,
//                 ),
//                 placeholder: 'assets/images/loading.gif',
//                 image: widget.news.image,
//                 fit: BoxFit.cover,
//                 width: 180,
//               ),
//             ),
//           ),
//           Container(
//             width:  MediaQuery.of(context).size.width*0.45,
//             padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(
//                       flex: 3, 
//                       child: CircleAvatar(
//                         backgroundImage:
//                         author.photoURL ==null|| author.photoURL==""
//                             ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2Fnews_default_image.png?alt=media&token=c18a786d-edc2-42f7-bf06-878906c85320") :
//                         NetworkImage(author.photoURL.toString()),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Flexible(
//                       flex: 7,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                             Text(
//                               author.displayName.toString(),
//                               maxLines: 1, 
//                               overflow: TextOverflow.fade,
//                                softWrap: false,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .caption
//                                   ?.copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: "Montserrat",
//                                 fontSize: 16,
//                               ),
//                             ),
                                                     
//                           Text(
//                             author.phoneNumber.toString(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText2
//                                 ?.copyWith(
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Montserrat",
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),

//                 Flexible(
//                   child: Text(
//                     widget.news.title,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Montserrat",
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   "Ngày đăng : ${widget.news.dateCreated.day}/${widget.news.dateCreated.month}/${widget.news.dateCreated.year}",
//                   textAlign: TextAlign.right,
//                   style: Theme.of(context).textTheme.bodyText2?.copyWith(

//                       fontFamily: "Montserrat",
//                       fontSize: 10,
//                       fontStyle: FontStyle.italic
//                   ),
//                 ),
//                 // md.MarkdownBody(data : content,
//                 // shrinkWrap : true),

//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     );
//   }

//   int daysBetween(DateTime from, DateTime to) {
//     from = DateTime(from.year, from.month, from.day);
//     to = DateTime(to.year, to.month, to.day);
//     return (to.difference(from).inHours / 24).round();
//   }

//    void openShowDetails(BuildContext context,News item) {
//     Navigator.pushNamed(context, '/news/details', arguments: item);
//   }
// }