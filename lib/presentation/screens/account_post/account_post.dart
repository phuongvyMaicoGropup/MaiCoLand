import 'package:flutter/material.dart';

class AccountPost extends StatefulWidget {
  const AccountPost({required this.authorId,Key? key}) : super(key: key);
  final String authorId;
  @override
  _AccountPostState createState() => _AccountPostState();
}

class _AccountPostState extends State<AccountPost> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text('Tabs Demo'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('Flight')),
                      Tab(child: Text('Train')),
                      Tab(child: Text('Car')),
                      Tab(child: Text('Cycle')),
                      Tab(child: Text('Boat')),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                Icon(Icons.flight, size: 350),
                Icon(Icons.directions_transit, size: 350),
                Icon(Icons.directions_car, size: 350),
                Icon(Icons.directions_bike, size: 350),
                Icon(Icons.directions_boat, size: 350),
              ],
            ),
          )),
    );
  }
}
