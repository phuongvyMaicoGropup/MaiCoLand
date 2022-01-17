import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_bloc.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_event.dart';
import 'package:land_app/logic/blocs/home/home_bloc/home_state.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/presentation/resources/app_themes.dart';
import 'package:land_app/presentation/screens/home/widgets/widget_home_card_land_plannings.dart';
class WidgetHomeLandPlanning extends StatelessWidget {

  List<LandPlanning> items = [
  ];
  
//  @override 
//  Widget build(BuildContext context){
//    return Builder(builder: (context){
//                 final homeState = context.watch<HomeBloc>().state;
//                 final LandPlanningState = context.watch<LandPlanningBloc>().state;
//                 if (homeState is LoadHome){
//                   items = homeState.
//                 }
//                 });
//  }
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<LandPlanningBloc, LandPlanningState>(
      builder: (context, state) {
        if ( state is LandPlanningLoaded) {
          
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
                  Navigator.pushNamed(context,"/landplannings");
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
                Container(height: 210.0, child : _buildListLandPlanning()),
              ],
            
          );
        } else if (state is LandPlanningNotLoaded){
          return Container(child : Text("Không load được"));
        } else return Container(child : Text("Lỗi"));
      
      },
    );
  }

  _buildListLandPlanning() {
    return ListView.builder(
                    scrollDirection: Axis.horizontal,

                      itemCount: items.length < 6 ? items.length : 5,
                    itemBuilder: (BuildContext context, int index) {
                      var item = items[index];
                      return GestureDetector(
                        onTap: ()=> 

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetItemLandPlanningCard(item: item,))),
                        child: WidgetHomeCardLandPlanning(
                          landPlanning: item,
                        ),
                      );
                    },
                  );
  }
}

class WidgetItemLandPlanningCard extends StatelessWidget {
  final LandPlanning item;

  WidgetItemLandPlanningCard( {required this.item, Key? key}) : super(key: key);

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return WidgetHomeCardLandPlanning(landPlanning: item);
  }

  void openShowDetails() {
    // Navigator.pushNamed(_context, AppRouter.SHOW_INFO, arguments: item.show);
  }
}

