import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_state.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/responses/user_reponse.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body:
                // MultiBlocProvider(

                //   providers: [
                //     // BlocProvider(create: (context) {
                //     //   return LandPlanningBloc();
                //     // }),
                //     // BlocProvider(create: (context) => HomeNewsBloc()),
                //     // BlocProvider(
                //     //     create: (context) => HomeShowsCategoryBloc(
                //     //         homeBloc: BlocProvider.of<HomeBloc>(context))),
                //   ],
                //   child:
                // ),
                Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.97,
                color: AppColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Builder(builder: (context) {
                    //   final authState =
                    //       context.watch<AuthenticationBloc>().state;
                    //   if (authState is AuthenticationAuthenticated) {
                    //     UserReponse user = authState.userReponse;
                    //     return WidgetHomeToolbar(user: user);
                    //   }
                    //   return Container();
                    // }),

                    const WidgetHomeBanner(),
                    SizedBox(
                      height: 10,
                    ),
                    // WidgetHomeCategories(),
                    // _buildContent(state),
                  ],
                ),
              ),
            )));
  }
}
