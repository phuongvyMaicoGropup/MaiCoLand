import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/screens/land_planning/widgets/land_planning_card.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class LandPlanningScreen extends StatefulWidget {
  const LandPlanningScreen({Key? key}) : super(key: key);

  @override
  _LandPlanningScreenState createState() => _LandPlanningScreenState();
}

class _LandPlanningScreenState extends State<LandPlanningScreen> {
  String searchKey = "";
  dvhcvn.Level1 idAddress1 = const dvhcvn.Level1("", "", dvhcvn.Type.huyen, []);
  dvhcvn.Level2 idAddress2 =
      const dvhcvn.Level2(0, "", "", dvhcvn.Type.huyen, []);
  final LandPlanningRepository _LandPlanningRepo = LandPlanningRepository();
  List<String> listSearch = [];

  final searchController = TextEditingController();
  static const _pageSize = 10;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Bản đồ quy hoạch đất');

  final PagingController<int, String> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  // This function is called whenever the text field changes
  void _updateSearchTerm(String searchTerm) {
    searchKey = searchTerm;
    _pagingController.refresh();
  }

  void selectedAddressId1(dvhcvn.Level1? id) {
    setState(() {
      idAddress1 = id!;
      idAddress2 = const dvhcvn.Level2(0, "", "", dvhcvn.Type.huyen, []);
    });
    _pagingController.refresh();
  }

  void selectedAddressId2(dvhcvn.Level2? id) {
    setState(() {
      idAddress2 = id!;
    });

    _pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _LandPlanningRepo.getLandPlanningPagination(
          pageKey, _pageSize, searchKey, idAddress1.id, idAddress2.id);
      if (mounted) {
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = "Đã có lỗi xảy ra. Vui lòng thử lại ";
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: Container(
              decoration: const BoxDecoration(
                  color: AppColors.appGreen1, shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    selectedAddressId1(
                        const dvhcvn.Level1("", "", dvhcvn.Type.huyen, []));
                    selectedAddressId2(
                        const dvhcvn.Level2(0, "", "", dvhcvn.Type.huyen, []));
                  },
                  icon: const Icon(Icons.replay_outlined,
                      color: AppColors.white, size: 30)),
            ),
            appBar: AppBar(
              // title:
              title: TextField(
                onChanged: _updateSearchTerm,
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Nhập tên bản đồ quy hoạch đất..',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _updateSearchTerm("");
                      searchController.text = "";
                    },
                    icon: const Icon(Icons.cancel))
              ],
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: DropdownButton<dvhcvn.Level1>(
                            underline: Container(),
                            isExpanded: true,
                            hint: Text(
                                idAddress1.name != ""
                                    ? idAddress1.name
                                    : "Tỉnh/Thành",
                                style: textMinorBlack),
                            items: dvhcvn.level1s.map((value) {
                              return DropdownMenuItem<dvhcvn.Level1>(
                                value: value,
                                child: Text(
                                  value.name,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => selectedAddressId1(value)
                            // style: white,
                            ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: DropdownButton<dvhcvn.Level2>(
                            underline: Container(),
                            isExpanded: true,
                            hint: Text(
                                idAddress2.name != ""
                                    ? idAddress2.name
                                    : "Huyện",
                                style: textMinorBlack),
                            items: idAddress1.children.map((value) {
                              return DropdownMenuItem<dvhcvn.Level2>(
                                value: value,
                                child: Text(
                                  value.name,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => selectedAddressId2(value)
                            // style: white,
                            ),
                      ),
                    ]),
                _buildListLandPlanning()
              ]),
            )));
  }

  Widget _buildListLandPlanning() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView<int, String>(
        shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<String>(
          animateTransitions: true,
          // [transitionDuration] has a default value of 250 milliseconds.
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, item, index) => FutureBuilder(
            future: _LandPlanningRepo.getLandById(item),
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return LandPlanningCard(
                    land: LandPlanning.fromJson(snapshot.data));
              }
              return WidgetSkeleton(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3);
            },
          ),
        ),
      ),
    );
  }
}
