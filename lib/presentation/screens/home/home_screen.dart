import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_event.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_state.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_event.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return LandPlanningBloc();
          
        }),
        // BlocProvider(
        //     create: (context) => RecommendedSeatsBloc(
        //         homeBloc: BlocProvider.of<HomeBloc>(context))),
        // BlocProvider(
        //     create: (context) => HomeShowsCategoryBloc(
        //         homeBloc: BlocProvider.of<HomeBloc>(context))),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                color: AppColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    WidgetHomeToolbar(),
                    const WidgetHomeBanner(),
                    WidgetHomeCategories(),
                    _buildContent(state),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Chọn loại bài đăng!'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/trade.png',
                                          width: 115,
                                        ),
                                        const Text('Buôn bán'),
                                      ],
                                    )),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.of(context, rootNavigator: true).pop();
                                    Navigator.of(context)
                                        .pushNamed("/news/add");
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/news.png',
                                        width: 115,
                                      ),
                                      const Text('Tin tức'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.add,
                    )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeLoaded) {

      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(RefreshHome());
          },
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Builder(
                builder :  (context){
                  final homeState = context.watch<HomeBloc>().state;
                final homeLandState = context.watch<LandPlanningBloc>().state;
                  if ( homeState is HomeLoaded ){
                    BlocProvider.of<LandPlanningBloc>(context).add(DisplayLandPlanning(homeState.response.landPlannings));
                  }
                  return WidgetHomeLandPlanning();
                  

                }
              )
              
                
              
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
