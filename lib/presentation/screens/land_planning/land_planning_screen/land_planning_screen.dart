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
  final LandPlanningRepository _LandPlanningRepo = LandPlanningRepository();
  final searchController = TextEditingController();
  static const _pageSize = 10;

  final PagingController<int, LandPlanning> _pagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, LandPlanning> _searchPagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  // This function is called whenever the text field changes

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (searchKey == "") {
        final newItems = await _LandPlanningRepo.getLandPlanningPagination(
            pageKey, _pageSize, searchKey);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        final newItems = await _LandPlanningRepo.getLandPlanningPagination(
            pageKey, _pageSize, searchKey);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _searchPagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _searchPagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = "Đã có lỗi xảy ra. Vui lòng thử lại ";
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchPagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: searchController,
                style: textMediumBlack.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w400),
                onChanged: (value) {
                  setState(() {
                    searchKey = value;
                  });
                  _searchPagingController.addPageRequestListener((pageKey) {
                    _fetchPage(pageKey);
                  });
                },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search, size: 16),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.only(
                      top: 13, bottom: 3.0, left: 5.0, right: 5.0),
                  hintText: "Bản đồ quy hoạch đất",
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: AppColors.gray.withOpacity(0.5),
                          width: 1.0,
                          style: BorderStyle.solid), //Border.al
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child:
                                            Icon(EvaIcons.pinOutline, size: 15),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Tất cả',
                                    ),
                                  ],
                                ),
                              ),
                              Icon(EvaIcons.arrowRightOutline),
                            ]))),
                _buildListLandPlanning()
              ]),
            )));
  }

  Widget _buildListLandPlanning() {
    return (searchKey == "")
        ? RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView<int, LandPlanning>(
              shrinkWrap: true,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<LandPlanning>(
                itemBuilder: (context, item, index) =>
                    LandPlanningCard(land: item),
              ),
            ),
          )
        : RefreshIndicator(
            onRefresh: () =>
                Future.sync(() => _searchPagingController.refresh()),
            child: PagedListView<int, LandPlanning>(
              shrinkWrap: true,
              pagingController: _searchPagingController,
              builderDelegate: PagedChildBuilderDelegate<LandPlanning>(
                itemBuilder: (context, item, index) =>
                    LandPlanningCard(land: item),
              ),
            ),
          );
  }
}
