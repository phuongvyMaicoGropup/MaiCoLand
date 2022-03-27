import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/helpers/dvhcvn_service.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/styles/app_themes.dart';
import 'package:maico_land/presentation/widgets/pdf_file_view.dart';

class LandPlanningDetailInfoScreen extends StatefulWidget {
  const LandPlanningDetailInfoScreen({required this.landPlanning, Key? key})
      : super(key: key);
  final LandPlanning landPlanning;

  @override
  State<LandPlanningDetailInfoScreen> createState() =>
      _LandPlanningDetailInfoScreenState();
}

class _LandPlanningDetailInfoScreenState
    extends State<LandPlanningDetailInfoScreen> {
  String path = "";
  @override
  void initState() {
    super.initState();

    PickFile.createFileOfPdfUrl(widget.landPlanning.filePdfUrl).then((f) {
      setState(() {
        path = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Thông tin quy hoạch"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.save, color: AppColors.white),
                onPressed: () async {
                  RepositoryProvider.of<LandPlanningRepository>(context)
                      .saveLand(DataLocalInfo(
                          widget.landPlanning.id, widget.landPlanning.title));
                  const snackBar = SnackBar(
                    dismissDirection: DismissDirection.up,
                    backgroundColor: AppColors.appGreen1,
                    content: Text('Đã lưu', style: whiteText),
                  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }),
            const SizedBox(width: 10)
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                  image: NetworkImage(widget.landPlanning.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.landPlanning.title,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.appGreen1.withOpacity(0.7),
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Ngày đăng : ${widget.landPlanning.createDate.day.toString()}/${widget.landPlanning.createDate.month.toString()}/${widget.landPlanning.createDate.year.toString()}",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                    // fontStyle: FontStyle.italic,
                    fontFamily: "Montserrat",
                    fontSize: 11,
                  ),
            ),
            const Divider(
              height: 25,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(EvaIcons.pinOutline,
                  color: AppColors.appGreen1, size: 20),
              Text("Vị trí: ",
                  style: textMinorGreen.copyWith(fontSize: 14), maxLines: 2),
              Expanded(
                child: Text(
                    DvhcvnService.getAddressFromId(
                        widget.landPlanning.address.idLevel1,
                        widget.landPlanning.address.idLevel2,
                        widget.landPlanning.address.idLevel3),
                    maxLines: 2),
              )
            ]),
            Row(children: [
              const Icon(EvaIcons.calendar,
                  color: AppColors.appGreen1, size: 20),
              Text("Ngày kết thúc: ",
                  style: textMinorGreen.copyWith(fontSize: 14)),
              Text(
                  "${widget.landPlanning.expirationDate.day}-${widget.landPlanning.expirationDate.month}-${widget.landPlanning.expirationDate.year}  ")
            ]),
            Row(children: [
              const Icon(EvaIcons.map, color: AppColors.appGreen1, size: 20),
              Text("Diện tích: ", style: textMinorGreen.copyWith(fontSize: 14)),
              Text("${widget.landPlanning.landArea} km²  ")
            ]),
            const SizedBox(height: 10),
            Container(
              child: Text(
                widget.landPlanning.content,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFScreen(
                            path: path, title: "Thông tin quy hoạch")),
                  );
                },
                child: const Text("Xem thông tin chi tiết")),
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
