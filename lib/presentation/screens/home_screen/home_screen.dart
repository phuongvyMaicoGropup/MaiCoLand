import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_state.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_top_viewed/bloc/top_news_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/widgets/widget_home_top_viewed_news.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("HomeNewsState before add" +
        BlocProvider.of<HomeNewsBloc>(context).state.toString());
    print("HomeNewsState after add" +
        BlocProvider.of<HomeNewsBloc>(context).state.toString());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeNewsBloc>(context).add(RefreshHomeNews());
            BlocProvider.of<HomeNewsBloc>(context).add(LoadHomeNews());
            BlocProvider.of<TopNewsBloc>(context).add(RefreshTopNews());
            BlocProvider.of<TopNewsBloc>(context).add(LoadTopNews());

            BlocProvider.of<HomeLandPlanningBloc>(context)
                .add(RefreshHomeLandPlanning());
            BlocProvider.of<HomeLandPlanningBloc>(context)
                .add(LoadHomeLandPlanning());
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Builder(builder: (context) {
                  final authState = context.watch<AuthenticationBloc>().state;
                  if (authState is AuthenticationAuthenticated) {
                    User user = authState.userReponse;
                    return WidgetHomeToolbar(user: user);
                  }
                  return Container();
                }),
              ),
              SliverToBoxAdapter(child: const WidgetHomeBanner()),
              SliverToBoxAdapter(child: WidgetHomeNews()),
              SliverToBoxAdapter(child: WidgetHomeLandPlanning()),
              SliverToBoxAdapter(
                child: WidgetHomeTopViewedNews(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    print("HomeNewsState at content " +
        BlocProvider.of<HomeNewsBloc>(context).state.toString());

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomeNewsBloc>(context).add(RefreshHomeNews());
          BlocProvider.of<HomeNewsBloc>(context).add(LoadHomeNews());
          print("HomeNewsState" +
              BlocProvider.of<HomeNewsBloc>(context).state.toString());

          BlocProvider.of<HomeLandPlanningBloc>(context)
              .add(RefreshHomeLandPlanning());
          BlocProvider.of<HomeLandPlanningBloc>(context)
              .add(LoadHomeLandPlanning());
        },
        child: ListView(
          cacheExtent: 99999,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const WidgetHomeBanner(),
            const SizedBox(
              height: 10,
            ),
            WidgetHomeNews(),
            Column(children: [
              Builder(builder: (context) {
                return WidgetHomeLandPlanning();
              }),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
