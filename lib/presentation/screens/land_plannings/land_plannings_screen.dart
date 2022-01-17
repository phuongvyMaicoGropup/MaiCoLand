import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_state.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_event.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_card_land_plannings.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_land_plannings.dart';
import 'package:land_app/presentation/screens/land_plannings/land_planning_details/land_planning_details_screen.dart';
import 'package:land_app/presentation/screens/land_plannings/widgets/land_planning_card.dart';
import 'package:provider/src/provider.dart';

class LandPlanningsScreen extends StatefulWidget {
  const LandPlanningsScreen({Key? key}) : super(key: key);

  @override
  _LandPlanningsScreenState createState() => _LandPlanningsScreenState();
}

class _LandPlanningsScreenState extends State<LandPlanningsScreen> {
  List<LandPlanning> items = [];
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final homeState = context.watch<HomeBloc>().state;
      if (homeState is HomeLoaded) {
        BlocProvider.of<LandPlanningBloc>(context)
            .add(DisplayLandPlanning(homeState.response.landPlannings));
      }
      return BlocBuilder<LandPlanningBloc, LandPlanningState>(
          builder: (context, state) {
        if (state is LandPlanningLoaded) {
          items = state.landPlannings;
          return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("Quy hoạch"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          _buildListLandPlanning()
                          ],
                      ),
                    
                  )));
        } else if (state is LandPlanningNotLoaded) {
          return Container(child: Text("Không load được"));
        } else
          return Container(child: Text("Lỗi"));
      });
    });
  }

  _buildListLandPlanning() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
    shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailMapLandPlanning(
                        landPlanning: item,
                      ))),
          child: LandPlanningCard(
            landPlanning: item,
          ),
        );
      },
    );
  }
}
