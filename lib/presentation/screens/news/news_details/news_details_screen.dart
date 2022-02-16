import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/news/news_detail_bloc/news_detail_bloc.dart';
import 'package:land_app/model/entity/app_user.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/model/repository/user_repository.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen(
      {required this.news,
      Key? key})
      : super(key: key);
  final News news;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final _userRepo = UserRepository();
  AppUser author =AppUser(uid: "", phoneNumber: "0123456789", displayName: "Chưa cập nhập", email: "Chưa cập nhập" ,photoURL: "");
    getInfo()async{
      var user = await _userRepo.getUserByUid(widget.news.authorId);
    setState(() {
        author = user; 
    });
  }
  @override
  Widget build(BuildContext context) {
    getInfo();
    // User widget.news.user! =RepositoryProvider.of<AuthenticationRepository>(context).user;  
    return  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Tin tức chi tiết"
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.news.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.news.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Ngày đăng : ${widget.news.dateCreated.day.toString()}/${widget.news.dateCreated.month.toString()}/${widget.news.dateCreated.year.toString()}",
                      style:
                      Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Montserrat",
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor),
                              shape: BoxShape.circle,
                              image: author.photoURL!= "" ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                         author.photoURL
                                  )):  const DecorationImage(
                                  fit: BoxFit.cover,
                                  image:AssetImage("assets/default_avatar.png"))
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[ Text(
                             author.displayName.toString() ,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                             author.phoneNumber.toString() == ""? "Chưa xác thực ": author.phoneNumber.toString() ,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          ]
                        ),
                      ),
                      //
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(child :Text(widget.news.content)),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
  }
}


// class NewsDetailsScreen extends StatelessWidget {
//   News news;

//   NewsDetailsScreen({required this.news});

//   // BuildContext? _context;
  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BlocProvider<NewsDetailBloc>(
//         create: (context) => NewsDetailBloc(
//           // sessionRepository: RepositoryProvider.of<SessionRepository>(context),
//         ),
//         child: BlocConsumer<NewsDetailBloc, NewsDetailState>(
//           buildWhen: (prev, current) {
//             return current is NewsDetailOpen ;
//           },
//           listener: (context, state) {
//             openBookCineTimeSlot();
//           },
//           builder: (context, state) {
//             // _context = context;
//             return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: const Text(
//                 "Tin tức chi tiết"
//               ),
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: ListView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                 children: [
//                   Stack(
//                     children:[ Container(
//                       height: 300,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.5),
//                             offset: const Offset(0, 2),
//                             blurRadius: 2,
//                           ),
//                         ],
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(5),
//                         ),
//                         image: DecorationImage(
//                           image: NetworkImage(widget.news.image),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//             right: 20,
//             bottom: 10,
//             child: Container(
//               padding: const EdgeInsets.only(
//                 top: 2,
//                 bottom: 2,
//                 left: 5,
//                 right: 10,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     offset: const Offset(2, 2),
//                     blurRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: <Widget>[
                 
//                   Text(
//                     (daysBetween(widget.news.dateCreated,DateTime.now())==0)? "Hôm nay":daysBetween(widget.news.dateCreated,DateTime.now()).toString()+ " ngày trước",
//                     style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       color: Colors.white,
//                       fontFamily: "Montserrat",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//                     ]
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     widget.news.title,
//                     style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Montserrat",
//                     ),
//                   ),
                  
//                   const Divider(
//                     height: 25,
//                     thickness: 1,
//                   ),
//                   Row(
//                     children: [
//                       Flexible(
//                         flex: 3,
//                         child: Container(
//                           width: 55,
//                           height: 55,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 4,
//                                   color:
//                                       Theme.of(context).scaffoldBackgroundColor),
//                               shape: BoxShape.circle,
//                               image: widget.news.user!.photoURL != "" ? DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: NetworkImage(
//                                          widget.news.user!.photoURL
//                                   )):  const DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image:AssetImage("assets/default_avatar.png"))
//                                   ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Flexible(
//                         flex: 7,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children:[ Text(
//                               widget.news.user!.displayName.toString() ,
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontFamily: "Montserrat",
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                               widget.news.user!.phoneNumber.toString() == ""? "Chưa xác thực ":  widget.news.user!.phoneNumber.toString() ,
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontFamily: "Montserrat",
//                             ),
//                           ),
//                           ]
//                         ),
//                       ),
//                       //
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Container(child :Text(widget.news.content)),
//                   const Divider(
//                     height: 25,
//                     thickness: 1,
//                   ),
//                 ],
//               ),
//             ),
//           );
//           //   return Scaffold(
//           //     body: Stack(
//           //       children: [
//           //         ListView(
//           //           children: <Widget>[
//           //             WidgetVideoPlayer(videoUrl: widget.News.trailer),
//           //             WidgetNewsDesc(News: News),
//           //             WidgetSpacer(height: 14),
//           //             WidgetOffers(News: News),
//           //             WidgetSpacer(height: 14),
//           //             WidgetNewsReview(News: News),
//           //             WidgetSpacer(height: 14),
//           //             WidgetNewsCasts(News: News),
//           //             WidgetSpacer(height: 70),
//           //           ],
//           //         ),
//           //         _buildBtnBookSeat(),
//           //       ],
//           //     ),
//           //   );
//           // 
//           },
//         ),
//       ),
//     );
//   }

//   // _buildBtnBookSeat() {
//   //   return Positioned(
//   //     bottom: 0,
//   //     right: 0,
//   //     left: 0,
//   //     child: Container(
//   //       height: 54,
//   //       child: FlatButton(
//   //         color: AppColors.DEFAULT,
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: <Widget>[
//   //             MySvgImage(
//   //               width: 18.25,
//   //               height: 16.1,
//   //               path: 'assets/ic_sofa.svg',
//   //             ),
//   //             WidgetSpacer(width: 5),
//   //             Text('Book seats', style: FONT_CONST.MEDIUM_WHITE_16),
//   //           ],
//   //         ),
//   //         onPressed: () {
//   //           BlocProvider.of<NewsDetailBloc>(_context).add(ClickBtnBook(News));
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }

//   void openBookCineTimeSlot() {
//     // BlocProvider.of<NewsDetailBloc>(_context).add(OpenedBookTimeSlotScreen());
//     // Navigator.pushNamed(_context, AppRouter.BOOK_TIME_SLOT, arguments: News);
//   }
//   int daysBetween(DateTime from, DateTime to) {
//     from = DateTime(from.year, from.month, from.day);
//     to = DateTime(to.year, to.month, to.day);
//     return (to.difference(from).inHours / 24).round();
//   }
// }