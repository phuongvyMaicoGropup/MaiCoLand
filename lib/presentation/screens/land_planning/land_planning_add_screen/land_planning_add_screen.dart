import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/land_planning_request.dart';
import 'package:maico_land/model/entities/geo_point.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class LandPlanningAddScreen extends StatefulWidget {
  const LandPlanningAddScreen({required this.address, Key? key})
      : super(key: key);
  final Address address;

  @override
  _LandPlanningAddScreenState createState() => _LandPlanningAddScreenState();
}

class _LandPlanningAddScreenState extends State<LandPlanningAddScreen> {
  String imagePath = "";
  final _landPlanningRepo = LandPlanningRepository();
  String filePdfPath = "";
  final _dioProvider = DioProvider();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final imageController = TextEditingController();
  final filePdfController = TextEditingController();
  final landAreaController = TextEditingController();
  final expirationDateController = TextEditingController();
  final leftTopxController = TextEditingController();
  final leftTopyController = TextEditingController();
  final rightTopxController = TextEditingController();
  final rightTopyController = TextEditingController();
  final leftBottomxController = TextEditingController();
  final leftBottomyController = TextEditingController();
  final rightBottomxController = TextEditingController();
  final rightBottomyController = TextEditingController();
  final String addressIdLevel1 = "";
  final String addressIdLevel2 = "";
  final String addressIdLevel3 = "";

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2060),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Tạo bản đồ quy hoạch",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _buildContent());
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 5, bottom: 20),
                  child: const Text(
                    'Thông tin quy hoạch',
                    style: textMediumGreen,
                  ),
                ),
                InputText(
                    controller: titleController,
                    width: MediaQuery.of(context).size.width,
                    label: "Tiêu đề",
                    inputType: TextInputType.multiline,
                    maxLines: 2,
                    minLines: 1,
                    validator: r"[\s\S]{10,}",
                    errorMessage: "Vui lòng nhập trên 10 kí tự "),
                const SizedBox(height: 10),
                InputText(
                    controller: contentController,
                    maxLines: 10,
                    minLines: 5,
                    inputType: TextInputType.multiline,
                    width: MediaQuery.of(context).size.width,
                    label: "Nội dung",
                    validator: r"[\s\S]{20,}",
                    errorMessage: "Vui lòng nhập trên 20 kí tự "),
                const SizedBox(height: 10),
                InputText(
                    controller: landAreaController,
                    maxLines: 1,
                    minLines: 1,
                    inputType: TextInputType.number,
                    width: MediaQuery.of(context).size.width,
                    label: "Diện tích",
                    validator: r".",
                    errorMessage: "Vui lòng không để trống"),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 5, bottom: 20),
                  child: const Text(
                    'Tọa độ hiển thị',
                    style: textMediumGreen,
                  ),
                ),
                InputPoint(
                    width: MediaQuery.of(context).size.width,
                    label: "Toạ độ trái (trên) ",
                    maxLines: 1,
                    controllerX: leftTopxController,
                    controllerY: leftTopyController,
                    validator: r".",
                    errorMessage: "Vui lòng nhập toạ độ "),
                const SizedBox(height: 10),
                InputPoint(
                    width: MediaQuery.of(context).size.width,
                    label: "Toạ độ phải (trên) ",
                    maxLines: 1,
                    controllerX: rightTopxController,
                    controllerY: rightTopyController,
                    validator: r'(^\d*\.?\d*)',
                    errorMessage: "Vui lòng nhập toạ độ "),
                const SizedBox(height: 10),
                InputPoint(
                    width: MediaQuery.of(context).size.width,
                    label: "Toạ độ trái (dưới) ",
                    maxLines: 1,
                    controllerX: leftBottomxController,
                    controllerY: leftBottomyController,
                    validator: r".",
                    errorMessage: "Vui lòng nhập toạ độ "),
                const SizedBox(height: 10),
                InputPoint(
                    width: MediaQuery.of(context).size.width,
                    label: "Toạ độ phải (dưới) ",
                    maxLines: 1,
                    controllerX: rightBottomxController,
                    controllerY: rightBottomyController,
                    validator: r".",
                    errorMessage: "Vui lòng nhập toạ độ "),
                const SizedBox(height: 10),
                const Text("File ",
                    style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
                TextButton(
                    onPressed: () async {
                      filePdfPath = await PickFile().pickFilePdf(context);
                      print(filePdfPath);
                      setState(() {});
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.picture_as_pdf),
                        const SizedBox(width: 10),
                        Text((filePdfPath != ""
                            ? filePdfPath.split('/').last
                            : "Đính kèm file PDF"))
                      ],
                    )),
                const Text("Thông tin chi tiết ",
                    style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
                TextButton(
                  onPressed: () async {
                    imagePath = await PickFile().pickOneImage(context);
                    setState(() {});
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.image),
                      const SizedBox(width: 10),
                      Text(imagePath != ""
                          ? imagePath.split('/').last
                          : "Đính kèm ảnh")
                    ],
                  ),
                ),
                const Text("Ngày kết thúc  ",
                    style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
                TextButton(
                  onPressed: () async {
                    _selectDate(context);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 10),
                        Text(DateFormat('dd/MM/yyyy').format(selectedDate))
                      ],
                    ),
                  ),
                ),
                SubmitedButton()
              ],
            ),
          )),
    );
  }

  bool validateForm() {
    if (RegExp(r"[\s\S]{10,}").hasMatch(titleController.text) &&
        RegExp(r"[\s\S]{20,}").hasMatch(contentController.text) &&
        checkDoubleValue(landAreaController.text) &&
        checkDoubleValue(leftTopxController.text) &&
        checkDoubleValue(leftTopyController.text) &&
        checkDoubleValue(leftBottomxController.text) &&
        checkDoubleValue(leftTopyController.text) &&
        checkDoubleValue(rightBottomxController.text) &&
        checkDoubleValue(rightBottomyController.text) &&
        checkDoubleValue(rightTopxController.text) &&
        checkDoubleValue(rightTopyController.text) &&
        imagePath.isNotEmpty &&
        filePdfPath.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkDoubleValue(String d) {
    try {
      double.parse(d);
    } catch (e) {
      print(d);
      return false;
    }
    return true;
  }

  Widget SubmitedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          child: const Text('Lưu', style: TextStyle(color: Colors.white)),
          key: const Key('LandPlanningAddForm_submitField'),
          onPressed: () async {
            print(widget.address);
            if (validateForm()) {
              try {
                var landPlanningRequest = LandPlanningRequest(
                  titleController.text,
                  contentController.text,
                  imagePath,
                  double.parse(landAreaController.text),
                  filePdfPath,
                  selectedDate,
                  GeoPoint(
                    double.parse(leftTopxController.text),
                    double.parse(leftTopyController.text),
                  ),
                  GeoPoint(
                    double.parse(rightTopxController.text),
                    double.parse(rightTopyController.text),
                  ),
                  GeoPoint(
                    double.parse(leftBottomxController.text),
                    double.parse(leftBottomyController.text),
                  ),
                  GeoPoint(
                    double.parse(rightBottomxController.text),
                    double.parse(rightBottomyController.text),
                  ),
                  widget.address,
                );
                print(landPlanningRequest);

                var result =
                    await _landPlanningRepo.create(landPlanningRequest);
                if (result == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Tạo bản đồ thành công"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          "Đã xảy ra lỗi khi tạo bản đồ . Vui lòng thử lại sau"),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Lỗi đăng bài. Vui lòng khởi động lại phần mềm!${e.toString()}"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Vui lòng nhập đầy đủ các trường và đính kèm các file!"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }),
    );
  }
}
