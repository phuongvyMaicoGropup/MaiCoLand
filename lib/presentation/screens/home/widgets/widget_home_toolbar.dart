
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/presentation/resources/app_colors.dart';

class WidgetHomeToolbar extends StatefulWidget {
  @override
  _WidgetHomeToolbarState createState() => _WidgetHomeToolbarState();
}

class _WidgetHomeToolbarState extends State<WidgetHomeToolbar> {
  
  
  @override
  Widget build(BuildContext context) {
       User user = RepositoryProvider.of<AuthenticationRepository>(context).user;
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          _buildAvatar(user.photoURL.toString()),
          _buildNames(user),
          _buildActions(),
        ],
      ),
    );
  }

  _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _clickSignOut();
            },
            child:const  Icon(Icons.logout, color : AppColors.appGreen1)
          ),
        ],
      ),
    );
  }

  _buildNames(User user) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Opacity(
             child: Row(
               children: <Widget>[
                 Text( user.phoneNumber.toString() == "" ?'Chưa xác thực': user.phoneNumber.toString() , style:  TextStyle(color :  AppColors.black),)
               ],
             ),
             opacity: 0.5,
           ),
           Text(user.displayName != "" ? user.displayName.toString():user.email.toString() ,
            maxLines : 1, style: const TextStyle(
              fontWeight: FontWeight.bold,
              color :  AppColors.black)),
         
        ],
      ),
    );
  }

  _buildAvatar(String photoURL) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(22)),
         
          image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    photoURL =="null"
                            ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/avatar%2Fdefault_avatar.png?alt=media&token=9f1c337b-1135-4aa9-9ff8-2529f3590af5") :
                        NetworkImage(photoURL)),
        ),
      ),
    );
  }

  _clickSignOut() {
    BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut());
  }
  _clickAccount(){
    Navigator.of(context).pushNamed("/account");
  }
}