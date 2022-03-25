import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/widgets/widgets.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class WidgetHomeLandPlanning extends StatelessWidget {
  List<LandPlanning> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLandPlanningBloc, HomeLandPlanningState>(
      builder: (context, state) {
        if (state is LandPlanningLoaded) {
          items = state.land;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeadingTextWidget(text: "Bản đồ quy hoạch"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/news");
                      },
                      child: Text(
                        "Xem thêm",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontFamily: "Montserrat",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(height: 200.0, child: _buildListLandPlanning()),
              ],
            ),
          );
        } else if (state is LandPlanningNotLoaded) {
          return Container(child: const Text("Không load được"));
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeadingTextWidget(text: "Tin tức"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/news");
                      },
                      child: Text(
                        "Xem thêm",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontFamily: "Montserrat",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 8, bottom: 8),
                              child: LandPlanningkeleton());
                        })),
              ],
            ),
          );
        }
      },
    );
  }

  _buildListLandPlanning() {
    return items.isEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
                  child: LandPlanningkeleton());
            })
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: items.length < 6 ? items.length : 5,
            itemBuilder: (BuildContext context, int index) {
              var item = items[index];
              return WidgetHomeCardLandPlanning(
                landPlanning: item,
              );
            },
          );
  }

  Widget LandPlanningkeleton() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WidgetSkeleton(height: 105, width: 170),
              SizedBox(height: 8),
              WidgetSkeleton(width: 130, height: 20),
              SizedBox(height: 8),
              WidgetSkeleton(width: 40, height: 20),
            ]));
  }

  void openShowDetails(BuildContext context, LandPlanning item) {
    Navigator.pushNamed(context, '/LandPlanning/details', arguments: item);
  }
}
