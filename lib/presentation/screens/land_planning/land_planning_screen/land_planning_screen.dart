import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maico_land/bloc/address_bloc/address.dart';
import 'package:maico_land/bloc/address_bloc/address_bloc.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/screens/land_planning/widgets/land_planning_card.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:maico_land/presentation/styles/app_themes.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class LandPlanningScreen extends StatefulWidget {
  const LandPlanningScreen({Key? key}) : super(key: key);

  @override
  _LandPlanningScreenState createState() => _LandPlanningScreenState();
}

class _LandPlanningScreenState extends State<LandPlanningScreen> {
  String searchKey = "";
  dvhcvn.Level1 idAddress1 = dvhcvn.Level1("", "", dvhcvn.Type.huyen, []);
  dvhcvn.Level2 idAddress2 = dvhcvn.Level2(0, "", "", dvhcvn.Type.huyen, []);
  final LandPlanningRepository _LandPlanningRepo = LandPlanningRepository();
  List<LandPlanning> listSearch = [];

  final searchController = TextEditingController();
  static const _pageSize = 10;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Bản đồ quy hoạch đất');

  final PagingController<int, LandPlanning> _pagingController =
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
      idAddress2 = dvhcvn.Level2(0, "", "", dvhcvn.Type.huyen, []);
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
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
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
              decoration: BoxDecoration(
                  color: AppColors.appGreen1, shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    selectedAddressId1(
                        dvhcvn.Level1("", "", dvhcvn.Type.huyen, []));
                    selectedAddressId2(
                        dvhcvn.Level2(0, "", "", dvhcvn.Type.huyen, []));
                  },
                  icon: Icon(Icons.replay_outlined,
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
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _updateSearchTerm("");
                      searchController.text = "";
                    },
                    icon: Icon(Icons.cancel))
              ],
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left: 10, right: 10),
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
      child: PagedListView<int, LandPlanning>(
        shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<LandPlanning>(
          animateTransitions: true,
          // [transitionDuration] has a default value of 250 milliseconds.
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, item, index) => LandPlanningCard(land: item),
        ),
      ),
    );
  }
}
