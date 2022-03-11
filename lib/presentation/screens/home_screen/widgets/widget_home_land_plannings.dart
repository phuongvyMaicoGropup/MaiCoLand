// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maico_land/presentation/widgets/widgets.dart';

// class WidgetHomeLandPlannning extends StatelessWidget {
//   List<LandPlannning> items = [];

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeLandPlannningBloc, HomeLandPlannningState>(
//       builder: (context, state) {
//         if (state is LandPlannningLoaded) {
//           items = state.LandPlannning;

//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const HeadingTextWidget(text: "Tin tức"),
//                     TextButton(
//                       onPressed: () {
//                         // Navigator.pushNamed(context, "/LandPlannning");
//                       },
//                       child: Text(
//                         "Xem thêm",
//                         style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                               fontFamily: "Montserrat",
//                               color: Theme.of(context).colorScheme.primary,
//                             ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Container(height: 200.0, child: _buildListLandPlannning()),
//               ],
//             ),
//           );
//         } else if (state is LandPlannningNotLoaded) {
//           return Container(child: Text("Không load được"));
//         } else
//           return Container(child: CircularProgressIndicator());
//       },
//     );
//   }

//   _buildListLandPlannning() {
//     return items.length == 0
//         ? ListView.builder(
//             padding: EdgeInsets.all(8),
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: 5,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                   padding:
//                       const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
//                   child: LandPlannningkeleton());
//             })
//         : ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: items.length < 6 ? items.length : 5,
//             itemBuilder: (BuildContext context, int index) {
//               var item = items[index];
//               return Container();
//               // return   WidgetHomeCardLandPlannning(
//               //       LandPlannning: item,
//               // );
//             },
//           );
//   }

//   Widget LandPlannningkeleton() {
//     return Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.02),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           WidgetSkeleton(height: 105, width: 170),
//           SizedBox(height: 8),
//           WidgetSkeleton(width: 130, height: 20),
//           SizedBox(height: 8),
//           WidgetSkeleton(width: 40, height: 20),
//         ]));
//   }

//   void openShowDetails(BuildContext context, LandPlannning item) {
//     Navigator.pushNamed(context, '/LandPlannning/details', arguments: item);
//   }
// }
