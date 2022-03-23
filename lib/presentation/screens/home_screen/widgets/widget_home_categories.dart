import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class Category {
  final String name;
  final IconData icon;
  final String route;
  // final Colors color;

  Category(this.name, this.icon, this.route); 
}

class WidgetHomeCategories extends StatefulWidget {
  @override
  _WidgetHomeCategoriesState createState() => _WidgetHomeCategoriesState();
}

class _WidgetHomeCategoriesState extends State<WidgetHomeCategories> {
  List<Category> items = [
    Category("Tin tức", Icons.library_books, "/news"),
    Category("Quy hoạch", Icons.map_rounded, "/landplannings",),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const HeadingTextWidget(text: "Khám phá"),
          const SizedBox(height: 14),
          _buildListCategory(),
        ],
      ),
    );
  }

  _buildListCategory() {
    return SizedBox(
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
          physics: const BouncingScrollPhysics(),
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
  }) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return GestureDetector(
      onTap: () {
        // openCategory(item.link);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 41,
            height: 41,
            decoration: BoxDecoration(
              color: AppColors.aliceBlue,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Icon(item.icon, color: AppColors.blueViolet),
            ),
          ),
          const SizedBox(height: 4),
          Text(item.name, ),
        ],
      ),
    );
  }

  void openCategory(String link) {
    Navigator.pushNamed(_context, link);
  }
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
