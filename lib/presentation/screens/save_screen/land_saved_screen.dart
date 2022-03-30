import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/session_repository.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

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
        appBar: AppBar(title: const Text("Các tin quy hoạch đã lưu")),
        body: FutureBuilder<List<DataLocalInfo>?>(
            future: RepositoryProvider.of<LandPlanningRepository>(context)
                .getSavedLand(),
            builder: (context, snapshot) {
              List<DataLocalInfo>? children;
              if (snapshot.hasData) {
                children = snapshot.data;
                if (children != []) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: children!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = children![index];
                      return GestureDetector(
                        onTap: () async {
                          print("Saved News wathc");
                          LandPlanning n = await RepositoryProvider.of<
                                  LandPlanningRepository>(context)
                              .getLandById(item.id);

                          Navigator.of(context)
                              .pushNamed("/landplanning/details", arguments: n);
                        },
                        child: Stack(children: [
                          SavedDataCard(
                            title: item.name,
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      RepositoryProvider.of<SessionRepository>(
                                              context)
                                          .removeLand(item);
                                      print("Removed Saved News");
                                    });
                                  },
                                  icon: const Icon(Icons.cancel))),
                        ]),
                      );
                    },
                  );
                } else {
                  return const Center(child: Icon(Icons.hourglass_empty));
                }
              } else if (snapshot.hasError) {
                return const Text("Đã xảy ra lỗi ");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
