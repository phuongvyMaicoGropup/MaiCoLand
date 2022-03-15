import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class CreateOption {
  final String title;
  final String description;
  final IconData icon;
  final String link;

  CreateOption(this.title, this.description, this.icon, this.link);
}

class CreateOptionScreen extends StatelessWidget {
  CreateOptionScreen({Key? key}) : super(key: key);

  List<CreateOption> createOptions = [
    CreateOption(
        "Đăng tin tức",
        "Đăng tin tức bất động sản / quy hoạch đất / thị trường ",
        Icons.newspaper_outlined,
        "/news/add"),
    CreateOption(
        "Đăng bản đồ quy hoạch",
        "Đăng bản đồ quy hoạch sử dụng đất/ dự án  ",
        Icons.map_outlined,
        "/landplanning/add")
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Đăng tin"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: createOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return OptionCard(
                  item: createOptions[index],
                );
              },
            )));
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({required this.item, Key? key}) : super(key: key);

  final CreateOption item;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(item.link);
      },
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.appGreen2, shape: BoxShape.circle),
                    child: Icon(item.icon, size: 30, color: Colors.white))),
            SizedBox(width: 10),
            Expanded(
                flex: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: mediumText),
                      SizedBox(height: 4),
                      Text(item.description, style: descriptionText)
                    ]))
          ],
        ),
      )),
    );
  }
}
