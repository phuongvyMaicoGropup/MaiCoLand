import 'package:flutter/material.dart';

class CreatePost {
  final String name;
  final String link;
  final String image;

  CreatePost({required this.name, required this.link, required this.image});
}

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({Key? key}) : super(key: key);

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  List<CreatePost> listChoice = <CreatePost>[
    CreatePost(
        name: "Tin tức", link: "/news/add", image: "assets/images/news.png"),
    CreatePost(
        name: "Quy hoạch", link: "/news/add", image: "assets/images/trade.png"),
  ];
  @override
  Widget build(BuildContext context) {
    print(listChoice.length);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Đăng loại tin"),
              centerTitle: true,
            ),
            body: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(listChoice.toList().length, (index) {
                  return Center(
                    child: clickChoice(listChoice[index]),
                  );
                }))));
  }

  Widget clickChoice(CreatePost choice) {
    return TextButton(
      onPressed: () {
        // Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).pushNamed(choice.link);
      },
      child: Column(
        children: [
          Image.asset(choice.image,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4),
          Text(choice.name.toString()),
        ],
      ),
    );
  }
}
