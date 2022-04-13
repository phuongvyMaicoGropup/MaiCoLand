import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/widgets/widgets.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class WidgetHomeLandPlanning extends StatelessWidget {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLandPlanningBloc, HomeLandPlanningState>(
      builder: (context, state) {
        if (state is HomeLandPlanningLoaded) {
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
                        Navigator.pushNamed(context, "/landplanning");
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
                    height: 210.0,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: items
                              .map((a) => FutureBuilder<LandPlanning>(
                                  future: RepositoryProvider.of<
                                          LandPlanningRepository>(context)
                                      .getLandById(a),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return WidgetHomeCardLandPlanning(
                                        landPlanning: snapshot.data!,
                                      );
                                    }
                                    return Container();
                                  }))
                              .toList(),
                        ))),
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
                    const HeadingTextWidget(text: "Bản đồ quy hoạch"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/landplanning");
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
                    height: MediaQuery.of(context).size.height * 0.3,
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

  // _buildListLandPlanning() {
  //   return SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       physics: BouncingScrollPhysics(),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: list,
  //       ));
  // }

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
