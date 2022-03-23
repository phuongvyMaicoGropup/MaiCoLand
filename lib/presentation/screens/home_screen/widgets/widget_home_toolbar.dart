import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class WidgetHomeToolbar extends StatefulWidget {
  @override
  final User user;
  const WidgetHomeToolbar({required this.user, Key? key}) : super(key: key);
  @override
  _WidgetHomeToolbarState createState() => _WidgetHomeToolbarState(user);
}

class _WidgetHomeToolbarState extends State<WidgetHomeToolbar> {
  User user;
  _WidgetHomeToolbarState(this.user);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: <Widget>[
          _buildAvatar(user.photoURL.toString()),
          _buildNames(user.userName),
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
              child: const Icon(Icons.logout, color: AppColors.appGreen1)),
        ],
      ),
    );
  }

  _buildNames(String username) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            child: Row(
              children: const <Widget>[
                Text(
                  'Chưa xác thực',
                  style: TextStyle(color: AppColors.black),
                )
              ],
            ),
            opacity: 0.5,
          ),
          Text(username,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.black)),
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
          borderRadius: const BorderRadius.all(Radius.circular(22)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: photoURL == ""
                  ? const NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/avatar%2Fdefault_avatar.png?alt=media&token=9f1c337b-1135-4aa9-9ff8-2529f3590af5")
                  : NetworkImage(photoURL)),
        ),
      ),
    );
  }

  _clickSignOut() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }

  _clickAccount() {
    Navigator.of(context).pushNamed("/account");
  }
}
