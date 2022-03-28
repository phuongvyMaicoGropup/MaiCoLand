import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_state.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/presentation/screens/home_screen/bloc/home_event.dart';
import 'package:maico_land/presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

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
    BlocProvider.of<HomeNewsBloc>(context).add(LoadHomeNews());

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.97,
              color: AppColors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Builder(builder: (context) {
                    final authState = context.watch<AuthenticationBloc>().state;
                    if (authState is AuthenticationAuthenticated) {
                      User user = authState.userReponse;
                      return WidgetHomeToolbar(user: user);
                    }
                    return Container();
                  }),
                  _buildContent()
                ],
              ),
            ))));
  }

  Widget _buildContent() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomeNewsBloc>(context).add(RefreshHomeNews());
          BlocProvider.of<HomeNewsBloc>(context).add(LoadHomeNews());

          BlocProvider.of<HomeLandPlanningBloc>(context)
              .add(RefreshHomeLandPlanning());
          BlocProvider.of<HomeLandPlanningBloc>(context)
              .add(LoadHomeLandPlanning());
        },
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const WidgetHomeBanner(),
            const SizedBox(
              height: 10,
            ),
            Builder(builder: (context) {
              return Column(children: [
                const SizedBox(height: 10),
                WidgetHomeNews(),
                WidgetHomeLandPlanning(),
              ]);
            })
          ],
        ),
      ),
    );
    // if (state is HomeLoaded) {

    // } else if (state is HomeLoading) {
    //   return Expanded(
    //     child: SingleChildScrollView(
    //       padding: const EdgeInsets.all(10),
    //       child: Column(
    //         children: <Widget>[
    //           WidgetSkeleton(
    //               width: MediaQuery.of(context).size.width * 0.9,
    //               height: MediaQuery.of(context).size.height * 0.23),
    //           const SizedBox(height: 10),
    //           WidgetSkeleton(
    //               width: MediaQuery.of(context).size.width * 0.9,
    //               height: MediaQuery.of(context).size.height * 0.002),
    //           const SizedBox(height: 10),
    //           Row(children: [
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.3,
    //                 height: MediaQuery.of(context).size.height * 0.03),
    //           ]),
    //           const SizedBox(height: 20),
    //           Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.4,
    //                 height: MediaQuery.of(context).size.height * 0.18),
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.4,
    //                 height: MediaQuery.of(context).size.height * 0.18),
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.1,
    //                 height: MediaQuery.of(context).size.height * 0.18),
    //           ]),
    //           const SizedBox(height: 10),
    //           WidgetSkeleton(
    //               width: MediaQuery.of(context).size.width * 0.9,
    //               height: MediaQuery.of(context).size.height * 0.002),
    //           const SizedBox(height: 10),
    //           Row(children: [
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.6,
    //                 height: MediaQuery.of(context).size.height * 0.03),
    //           ]),
    //           const SizedBox(height: 20),
    //           Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.4,
    //                 height: MediaQuery.of(context).size.height * 0.18),
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.4,
    //                 height: MediaQuery.of(context).size.height * 0.18),
    //             WidgetSkeleton(
    //                 width: MediaQuery.of(context).size.width * 0.1,
    //                 height: MediaQuery.of(context).size.height * 0.18),
    //           ]),
    //         ],
    //       ),
    //     ),
    //   );
    // } else if (state is HomeNotLoaded) {
    //   return Expanded(
    //     child: Center(
    //         child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //           GestureDetector(
    //             onTap: () {
    //               BlocProvider.of<HomeBloc>(context).add(RefreshHome());
    //               BlocProvider.of<HomeBloc>(context).add(LoadHome());
    //             },
    //             child: const Icon(EvaIcons.wifiOffOutline,
    //                 color: AppColors.appGreen1, size: 50),
    //           ),
    //           const SizedBox(height: 20),
    //           const Text("Mất kết nối",
    //               style: TextStyle(color: AppColors.appGreen1, fontSize: 20)),
    //         ])),
    //   );
    // } else {
    //   return const Expanded(
    //     child: Center(
    //       child: Text('Unknown state'),
    //     ),
    //   );
    // }
  }
}
