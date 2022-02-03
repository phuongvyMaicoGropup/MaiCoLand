import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/authentication_repository.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen(
      {required this.news,
      Key? key})
      : super(key: key);
  final News news;
   
 
  @override
  Widget build(BuildContext context) {
    User author =RepositoryProvider.of<AuthenticationRepository>(context).user;
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
                        image: NetworkImage(news.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Ngày đăng : ${news.dateCreated.day.toString()}/${news.dateCreated.month.toString()}/${news.dateCreated.year.toString()}",
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
                              image: author.photoURL!= null ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                         author.photoURL!
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
                          children:[ Text(
                             author.email.toString() ,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                             author.phoneNumber.toString() ,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ]
                        ),
                      ),
                      //
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(child :Text(news.content)),
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
