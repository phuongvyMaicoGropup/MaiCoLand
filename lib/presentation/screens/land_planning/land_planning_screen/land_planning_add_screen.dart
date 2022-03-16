import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:maico_land/bloc/land_planning_add_bloc/land_planning_add_bloc.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/land_planning_request.dart';
import 'package:maico_land/model/entities/GeoPoint.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/presentation/widgets/input_text.dart';
import 'package:maico_land/presentation/widgets/label_widget.dart';
import 'package:maico_land/presentation/widgets/widget_input_text_field.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class LandPlanningAddScreen extends StatefulWidget {
  const LandPlanningAddScreen({required this.address, Key? key})
      : super(key: key);
  final Address address;

  @override
  _LandPlanningAddScreenState createState() => _LandPlanningAddScreenState();
}

class _LandPlanningAddScreenState extends State<LandPlanningAddScreen> {
  String imagePath = "Chưa cập nhập thông tin";
  final _landPlanningRepo = LandPlanningRepository();
  String filePdfPath = "Chưa cập nhập thông tin ";
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
                    validator: r".",
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
                Text("File ",
                    style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
                TextButton(
                    onPressed: () async {
                      filePdfPath = await PickFile().pickFilePdf(context);
                      print(filePdfPath);
                    },
                    child: Text(filePdfPath.split('/').last)),
                Text("Thông tin chi tiết ",
                    style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
                TextButton(
                  onPressed: () async {
                    imagePath = await PickFile().pickImage(context);
                    print(imagePath);
                  },
                  child: Text(imagePath.split('/').last),
                ),
                Text("Ngày kết thúc  ",
                    style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
                TextButton(
                  onPressed: () async {
                    _selectDate(context);
                  },
                  child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                ),
                SubmitedButton()
              ],
            ),
          )),
    );
  }

  Widget SubmitedButton() {
    return ElevatedButton(
        child: const Text('Lưu', style: TextStyle(color: Colors.white)),
        onPressed: () async {
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
                double.parse(leftTopxController.text),
              ),
              GeoPoint(
                double.parse(leftTopxController.text),
                double.parse(leftTopxController.text),
              ),
              GeoPoint(
                double.parse(leftTopxController.text),
                double.parse(leftTopxController.text),
              ),
              GeoPoint(
                double.parse(leftTopxController.text),
                double.parse(leftTopxController.text),
              ),
              widget.address,
            );
            print(landPlanningRequest);

            var result = await _landPlanningRepo.create(landPlanningRequest);
            if (result == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Tạo bản đồ thành công"),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      "Đã xảy ra lỗi khi tạo bản đồ . Vui lòng thử lại sau"),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (route) => false);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Lỗi đăng bài. Vui lòng khởi động lại phần mềm!"),
                backgroundColor: Colors.red,
              ),
            );
            print(e.toString());
          }
        });
  }
}
