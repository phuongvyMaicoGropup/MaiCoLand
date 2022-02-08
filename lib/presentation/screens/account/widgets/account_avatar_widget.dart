import 'package:flutter/material.dart';

class AccountAvatarWidget extends StatelessWidget {
  const AccountAvatarWidget({ Key? key, required this.photoURL }) : super(key: key);
  final String photoURL; 
  @override
  Widget build(BuildContext context) {
    return  Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image:  DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    photoURL =="null"
                            ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/avatar%2Fdefault_avatar.png?alt=media&token=9f1c337b-1135-4aa9-9ff8-2529f3590af5") :
                        NetworkImage(photoURL))),
                      ),
                      // Positioned(
                      //     bottom: 0,
                      //     right: 0,
                      //     child: Container(
                      //       height: 40,
                      //       width: 40,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           width: 4,
                      //           color:
                      //               Theme.of(context).scaffoldBackgroundColor,
                      //         ),
                      //         color: Colors.green,
                      //       ),
                      //       child: GestureDetector(
                      //         onTap: () =>{},
                      //         child: const Icon(
                      //           Icons.edit,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                );
             
  }
}