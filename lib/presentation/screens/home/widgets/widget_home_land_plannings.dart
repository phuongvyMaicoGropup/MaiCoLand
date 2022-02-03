import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_card_land_plannings.dart';
import 'package:land_app/presentation/screens/land_plannings/land_planning_details/land_planning_details_screen.dart';

class WidgetHomeLandPlanning extends StatelessWidget {
  List<LandPlanning> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandPlanningBloc, LandPlanningState>(
      builder: (context, state) {
        if (state is LandPlanningLoaded) {
          items = state.landPlannings;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Quy hoạch",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/landplannings");
                      },
                      child: Text(
                        "Xem thêm",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontFamily: "Montserrat",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Container(height: 210.0, child: _buildListLandPlanning()),
            ],
          );
        } else if (state is LandPlanningNotLoaded) {
          return Container(child: Text("Không load được"));
        } else {
          return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
        }
      },
    );
  }

  _buildListLandPlanning() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length < 6 ? items.length : 5,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return  GestureDetector(
          onTap : ()=>  Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => DetailMapLandPlanning(
                        landPlanning: item,
                      ))),
          child: WidgetHomeCardLandPlanning(
              landPlanning: item,
            
          ),
        );
      },
    );
  }
}