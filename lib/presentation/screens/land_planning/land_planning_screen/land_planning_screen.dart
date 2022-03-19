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

  Future<void> _fetchPage(int pageKey) async {
    try {
        final newItems = await _LandPlanningRepo.getLandPlanningPagination(
            pageKey, _pageSize, searchKey);
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
            appBar: AppBar(
              // title: 
              title:  TextField(
     onChanged: (value){
       setState(() {
         searchKey = value; 
       });
       listSearch.clear();
       _pagingController.itemList!.forEach((element) { if (element.title.contains(searchKey) ) listSearch.add(element); });
      //  _pagingController.
     },
    decoration: InputDecoration(
    
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
                 Icon(Icons.cancel)

  ],
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
    return searchKey == ""?RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView<int, LandPlanning>(
              shrinkWrap: true,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<LandPlanning>(
                itemBuilder: (context, item, index) =>
                    LandPlanningCard(land: item),
              ),
            ),
          ): 
          ListView.builder(
            shrinkWrap: true,
            itemCount: listSearch.length, 
            itemBuilder: ((context, index) => LandPlanningCard(land: listSearch[index])));
          ;
        
  }
}
