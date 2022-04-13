import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/screens/land_planning/widgets/land_planning_card.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class AccountLand extends StatefulWidget {
  const AccountLand({required this.authorId, this.showTitle, Key? key})
      : super(key: key);
  final String authorId;
  final bool? showTitle;
  @override
  _AccountLandState createState() => _AccountLandState();
}

class _AccountLandState extends State<AccountLand>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<AccountLand> {
  late LandPlanningRepository _LandPlanningRepo;
  @override
  void initState() {
    super.initState();
    _LandPlanningRepo = RepositoryProvider.of<LandPlanningRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.showTitle == null
            ? AppBar(title: const Text("Bản đồ quy hoạch của tôi"))
            : null,
        body: FutureBuilder<List<String>?>(
            future: RepositoryProvider.of<LandPlanningRepository>(context)
                .getLandByAuthorId(widget.authorId),
            builder: (context, snapshot) {
              List<String>? children = [];
              if (snapshot.data == null) {
                return const Center(
                  child: Text(
                    "Trống",
                    style: textMediumBlack,
                  ),
                );
              }
              if (snapshot.hasData) {
                children = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: children!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = children![index];
                    return GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                              "/landplanning/details",
                              arguments: item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: FutureBuilder(
                            future: _LandPlanningRepo.getLandById(item),
                            initialData: [],
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return LandPlanningCard(
                                    land: LandPlanning.fromJson(snapshot.data));
                              }
                              return WidgetSkeleton(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3);
                            },
                          ),
                        ));
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
