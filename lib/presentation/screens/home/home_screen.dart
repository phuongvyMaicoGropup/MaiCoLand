import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_event.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_state.dart';
import 'package:land_app/logic/blocs/home/home_news_bloc/news_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_event.dart';
import 'package:land_app/presentation/resources/resources.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_banner.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_toolbar.dart';
import 'package:land_app/presentation/screens/home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadHome());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray.withAlpha(30),
        body: MultiBlocProvider(
          
          providers: [
            BlocProvider(create: (context) {
              return LandPlanningBloc();
            }),
            BlocProvider(create: (context) => HomeNewsBloc()),
            // BlocProvider(
            //     create: (context) => HomeShowsCategoryBloc(
            //         homeBloc: BlocProvider.of<HomeBloc>(context))),
          ],
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Center(
                child: Container(
                      width: MediaQuery.of(context).size.width*0.97,
                       color: AppColors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          WidgetHomeToolbar(),
                          const WidgetHomeBanner(),
                          SizedBox(height: 10,),
                          WidgetHomeCategories(),
                          _buildContent(state),
                        ],
                      ),
                    ),
              )
                  
                 
                
            ;
            },
          ),
        ),
      ),
    );
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
              Builder(builder: (context) {
                final homeState = context.watch<HomeBloc>().state;
                if (homeState is HomeLoaded) {
                  BlocProvider.of<LandPlanningBloc>(context).add(
                      DisplayLandPlanning(homeState.response.landPlannings));
                  BlocProvider.of<HomeNewsBloc>(context)
                      .add(HomeDisplayNews(homeState.response.news));
                }
                return Column(children: [
                  WidgetHomeLandPlanning(),
                  const SizedBox(height : 10),

                  WidgetHomeNews(),
                ]);
              })
            ],
          ),
        ),
      );
    } else if (state is HomeLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
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
