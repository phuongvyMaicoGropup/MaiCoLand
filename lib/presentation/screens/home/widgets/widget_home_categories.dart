
import 'package:flutter/material.dart';

import 'package:land_app/model/entity/category.dart';
import 'package:land_app/presentation/resources/resources.dart';

class WidgetHomeCategories extends StatefulWidget {
  @override
  _WidgetHomeCategoriesState createState() => _WidgetHomeCategoriesState();
}

class _WidgetHomeCategoriesState extends State<WidgetHomeCategories> {
  List<Category> items = [
   Category("Tin tức", Icons.library_books),
   Category("Quy hoạch", Icons.map_rounded),
  ];

  @override
  Widget build(BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
                "Tiện ích",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color : AppColors.appGreen1
                ),
              
            ),
                const SizedBox(height: 14),
                _buildListCategory(),
              ],
            ),
          );
  }

  _buildListCategory() {
    return Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var item = items[index];

            return _WidgetItemCategory(item: item);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 30);
          },
          physics: BouncingScrollPhysics(),
          itemCount: items.length,
        ),
      ),
    );
  }
}

class _WidgetItemCategory extends StatelessWidget {
  final Category item;

  _WidgetItemCategory({
    Key? key,
    required this.item,
    }
  ) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return GestureDetector(
      onTap: () {
        // openAllShows();
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            child: Center(
              
              child: Icon( item.icon, color : AppColors.appGreen2 ),
            ),
          ),
          const SizedBox(height: 4),
          Text(item.name, style : textMinorGreen),
        ],
      ),
    );
  }

  // void openAllShows() {
  //   Navigator.pushNamed(_context, AppRouter.ALL_SHOWS);
  // }
}

// class _ItemCategoryVM {
//   Categoryy categoryy;
//   String image;
//   String title;

//   _ItemCategoryVM.fromCategory(this.categoryy) {
//     image = "assets/${this.categoryy.icon}";
//     title = this.categoryy.name;
//   }
// }