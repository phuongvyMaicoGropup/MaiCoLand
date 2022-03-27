import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/screens/land_planning/widgets/land_planning_card.dart';

class LandSavedScreen extends StatefulWidget {
  const LandSavedScreen({Key? key}) : super(key: key);

  @override
  State<LandSavedScreen> createState() => _LandSavedScreenState();
}

class _LandSavedScreenState extends State<LandSavedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Các tin tức đã lưu")),
        body: FutureBuilder<List<LandPlanning>?>(
            future: RepositoryProvider.of<LandPlanningRepository>(context)
                .getSavedLand(),
            builder: (context, snapshot) {
              List<LandPlanning>? children = [];
              if (snapshot.hasData) {
                children = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: children!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = children![index];
                    return LandPlanningCard(
                      land: item,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Đã xảy ra lỗi ");
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
