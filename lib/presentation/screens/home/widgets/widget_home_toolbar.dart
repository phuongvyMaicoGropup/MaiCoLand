
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
      color: AppColors.appGreenLightColor,
      height: 70,
      child: Row(
        children: <Widget>[
          _buildAvatar(),
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
           Text(user.displayName != "" ? user.displayName.toString():user.email.toString() , maxLines : 1, style: const TextStyle(color :  AppColors.appGreen1)),
          GestureDetector(
            onTap: () {
              _clickAccount();
            },
            child: Opacity(
              child: Row(
                children: <Widget>[
                  Text('Chưa xác thực', style:  TextStyle(color :  AppColors.appGreen1),)
                ],
              ),
              opacity: 0.5,
            ),
          )
        ],
      ),
    );
  }

  _buildAvatar() {
    return GestureDetector(
      onTap: ()=> _clickAccount(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(22)),
            border: Border.all(
              color:  AppColors.appGreen1,
              width: 2.0,
            ),
            image: DecorationImage(image: AssetImage("assets/default_avatar.png")),
          ),
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