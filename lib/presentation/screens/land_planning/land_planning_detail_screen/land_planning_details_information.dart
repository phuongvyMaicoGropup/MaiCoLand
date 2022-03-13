import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/land_planning.dart';


class DetailLandPlanning extends StatelessWidget {
  const DetailLandPlanning({required this.landPlanning, Key? key}) : super(key: key);
  final LandPlanning landPlanning;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thông tin quy hoạch" ),
        leading: IconButton(
        onPressed: () {
        Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),),
      ),
      body: Padding(    
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          padding:
          const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                // borderRadius: const BorderRadius.all(
                //   Radius.circular(5),
                // ),
                image: DecorationImage(
                  image: NetworkImage(landPlanning.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              landPlanning.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: Text(
                "Ngày đăng : ${landPlanning.createDate.day.toString()}/${landPlanning.createDate.month.toString()}/${landPlanning.createDate.year.toString()}",
                style:
                Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontFamily: "Montserrat",
                  fontSize: 11,
                ),
              ),
            ),
            const Divider(
              height: 25,
              thickness: 1,
            ),

            const SizedBox(height: 10),
            Container(
              child: Text(
                landPlanning.content,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 15,

                  fontFamily: "Montserrat",

                ),
              ),
            ),
            const Divider(
              height: 25,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
