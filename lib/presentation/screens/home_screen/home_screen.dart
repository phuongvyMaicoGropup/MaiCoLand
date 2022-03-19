import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_state.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/responses/user_reponse.dart';
import 'package:maico_land/presentation/screens/home_screen/bloc/home_event.dart';
import 'package:maico_land/presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/land_planning_skeleton.dart';
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.97,
                color: AppColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Builder(builder: (context) {
                      final authState =
                          context.watch<AuthenticationBloc>().state;
                      if (authState is AuthenticationAuthenticated) {
                        User user = authState.userReponse;
                        return WidgetHomeToolbar(user: user);
                      }
                      return Container();
                    }),
                    _buildContent(state)
                  ],
                ),
              ));
            })));
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeLoaded) {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(RefreshHome());
            BlocProvider.of<HomeBloc>(context).add(LoadHome());
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
                final homeState = context.watch<HomeBloc>().state;
                if (homeState is HomeLoaded) {
                  BlocProvider.of<HomeLandPlanningBloc>(context).add(
                      HomeDisplayLandPlanning(
                          homeState.response.landPlannings));
                  BlocProvider.of<HomeNewsBloc>(context)
                      .add(HomeDisplayNews(homeState.response.news));
                }
                return Column(children: [
                  // WidgetHomeLandPlanning(),
                  const SizedBox(height: 10),
                  WidgetHomeNews(),
                  WidgetHomeLandPlanning(),
                ]);
              })
            ],
          ),
        ),
      );
    } else if (state is HomeLoading) {
      return Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              WidgetSkeleton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.23),
              const SizedBox(height: 10),
              WidgetSkeleton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.002),
              const SizedBox(height: 10),
              Row(children: [
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.03),
              ]),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18),
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18),
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.18),
              ]),
              const SizedBox(height: 10),
              WidgetSkeleton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.002),
              const SizedBox(height: 10),
              Row(children: [
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.03),
              ]),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18),
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18),
                WidgetSkeleton(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.18),
              ]),
            ],
          ),
        ),
      );
    } else if (state is HomeNotLoaded) {
      return const Expanded(
        child: Center(
          child: Text('Cannot load data'),
        ),
      );
    } else {
      return const Expanded(
        child: Center(
          child: Text('Unknown state'),
        ),
      );
    }
  }
}
