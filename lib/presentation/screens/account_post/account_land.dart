import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/screens/land_planning/widgets/land_planning_card.dart';
import 'package:maico_land/presentation/screens/news/widgets/news_card.dart';

class AccountLand extends StatefulWidget {
  const AccountLand({
    required this.authorId,Key? key}) : super(key: key);
  final String authorId;
  @override
  _AccountLandState createState() => _AccountLandState();
}

class _AccountLandState extends State<AccountLand> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Bản đồ quy hoạch của tôi")),
        body: FutureBuilder<List<LandPlanning>?>(
            future: RepositoryProvider.of<LandPlanningRepository>(context).getLandByAuthorId(widget.authorId),
            builder: (context, snapshot) {
              List<LandPlanning>? children = [];
              if (snapshot.hasData) {
                children = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: children!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = children![index];
                    return GestureDetector(
                        onTap: () async {

                          Navigator.of(context)
                              .pushNamed("/landplanning/details", arguments: item);
                        },
                        child: LandPlanningCard(land: item,)
                    );
                  },
                );
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
