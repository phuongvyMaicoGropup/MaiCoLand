import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maico_land/bloc/news_add_bloc/news_add_bloc.dart';
import 'package:maico_land/bloc/sale_post_bloc/sale_post_bloc.dart';
import 'package:maico_land/bloc/sale_post_bloc/sale_post_event.dart';
import 'package:maico_land/bloc/sale_post_bloc/sale_post_state.dart';
import 'package:maico_land/model/api/request/news_request.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:maico_land/bloc/address_bloc/address_bloc.dart';
import 'package:maico_land/bloc/address_bloc/address_event.dart';
import 'package:maico_land/bloc/address_bloc/address_state.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_location_picker/open_location_picker.dart' hide Address;
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

import '../../../model/api/dio_provider.dart';
import '../../../model/repositories/news_repository.dart';

class SalePostScreen extends StatefulWidget {
  UserRepository userRepo;
  SalePostScreen(this.userRepo, {Key? key}) : super(key: key);

  @override
  State<SalePostScreen> createState() => _SalePostScreenState();
}

List list = [
  "Nhà mặt phố",
  "Căn hộ",
  "Nhà riêng",
  "Đất",
  "Bất động sản khác",
  "Đất nền dự án"
];

class _SalePostScreenState extends State<SalePostScreen> {
  final NewsRepository _newsRepo = NewsRepository();
  final DioProvider _dioProvider = DioProvider();
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ScrollController bottomsheetcon = ScrollController();
  dvhcvn.Level1? dropdownValue1;
  dvhcvn.Level2? dropdownValue2;
  dvhcvn.Level3? dropdownValue3;

  final _formKey = GlobalKey<FormState>();
  String type = "";
  bool isNegotiable = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalePostBloc, SalePostState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Đăng tin"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Tiêu đề', style: TextStyle(color: Colors.grey)),
                ),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    return validateMyInputwithLength(value!, 15);
                  },
                ),
                sizebox(),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Loại bất động sản',
                      style: TextStyle(color: Colors.grey)),
                ),
                selectType(),
                const Divider(color: AppColors.grey),
                sizebox(),

                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Địa chỉ', style: TextStyle(color: Colors.grey)),
                ),
                selectAddress(context),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    return validateAdress(value!);
                  },
                ),
                // OpenMapPicker(
                //   decoration: const InputDecoration(hintText: "My location"),
                //   onSaved: (FormattedLocation? newValue) {
                //     /// save new value
                //   },
                // ),
                sizebox(),
                areaWidget(),
                sizebox(),
                priceWidget(),
                checkBoxWidget(),
                sizebox(),
                descriptionWidget(),
                _ImageInput(),
                SizedBox(
                  width: double.infinity,
                  child: isLoading == false
                      ? ElevatedButton(
                          key: const Key('NewsAddForm_continue_raisedButton'),
                          child: const Text('Lưu',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            print("oke");

                            if (_formKey.currentState!.validate()) {
                              bool check = true;
                              if (type.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Vui lòng chọn loại bất động sản"),
                                  backgroundColor: AppColors.darkRed,
                                ));
                                check = false;
                              }
                              if (state.images.value == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Vui lòng chọn chọn ảnh"),
                                  backgroundColor: AppColors.darkRed,
                                ));
                                check = false;
                              }
                              if (check = true) {
                                SaveSalePost(state);
                              }
                            }
                          })
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<LatLng?> _getCurrentLocationUsingLocationPackage() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception("Service is not enabled");
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception("Permission not granted");
      }
    }
    var _locationData = await location.getLocation();

    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  Widget _buildLocationPackage() {
    return OpenMapSettings(
      currentLocationMarker: (context, location) {
        return Marker(
            point: location,
            builder: (BuildContext context) {
              return Container();
            });
      },
      onError: (context, error) {},
      getCurrentLocation: _getCurrentLocationUsingLocationPackage,
      reverseZoom: ReverseZoom.building,
      getLocationStream: () => Geolocator.getPositionStream()
          .map((event) => LatLng(event.latitude, event.longitude)),
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: const Locale("vi"),
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('vi', ''), // English, no country code
          // Spanish, no country code
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
      ),
    );
  }

  Widget areaWidget() {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Diện tích', style: TextStyle(color: Colors.grey)),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: areaController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: (value) {
                  return validateNyInputNotEmty(value!);
                },
              ),
            ),
            const Text('m2', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget priceWidget() {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Giá', style: TextStyle(color: Colors.grey)),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: (value) {
                  return validateNyInputNotEmty(value!);
                },
              ),
            ),
            const Text('VNĐ', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget descriptionWidget() {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Mô tả', style: TextStyle(color: Colors.grey)),
        ),
        sizebox(),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
                    decoration: boxBorderWhiteWithGreenLine,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 10,
                        validator: (value) {
                          return validateNyInputNotEmty(value!);
                        },
                        controller: desController,
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none),
                      ),
                    ))),
          ],
        )
      ],
    );
  }

  Widget sizebox() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget buttonOnBottomSheet(String value) {
    return TextButton(
      child: Text(
        value,
        style: mediumText,
      ),
      onPressed: () {
        setState(() {
          type = value;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget selectType() {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type == "" ? "Chọn loại bất động sản" : type),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
      onPressed: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
                child: Column(
              children: list.map((e) => buttonOnBottomSheet(e)).toList(),
            )),
          ),
        );
      },
    );
  }

  Widget selectAddress(BuildContext _) =>
      BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 13),
                padding: const EdgeInsets.only(left: 8, right: 8),
                decoration: boxBorderWhiteWithGreenLine,
                child: DropdownButton<dvhcvn.Level1>(
                  alignment: AlignmentDirectional.centerStart,
                  hint: Text(
                      state.level1.name != ""
                          ? state.level1.name
                          : "- Tỉnh thành -",
                      style: const TextStyle(color: Colors.black)),
                  value: dropdownValue1,
                  focusColor: const Color.fromARGB(255, 70, 126, 83),
                  icon: const Icon(Icons.arrow_drop_down,
                      size: 18, color: Colors.black),
                  // elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  isExpanded: true,
                  iconEnabledColor: Colors.white,

                  underline: Container(),
                  onChanged: (dvhcvn.Level1? newValue) {
                    context
                        .read<AddressBloc>()
                        .add(AddressIdLevel1Selected(item: newValue!));
                    dropdownValue1 = newValue;
                    showAdress();
                  },
                  items: dvhcvn.level1s
                      .map<DropdownMenuItem<dvhcvn.Level1>>((value) {
                    return DropdownMenuItem<dvhcvn.Level1>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 8, right: 8),
                decoration: boxBorderWhiteWithGreenLine,
                child: DropdownButton<dvhcvn.Level2>(
                  hint: Text(
                      state.level2.name != ""
                          ? state.level2.name
                          : "- Quận huyện -",
                      style: const TextStyle(color: Colors.black)),
                  isExpanded: true,
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward,
                      size: 18, color: Colors.black),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(),
                  onChanged: (dvhcvn.Level2? newValue) {
                    context
                        .read<AddressBloc>()
                        .add(AddressIdLevel2Selected(item: newValue!));
                    dropdownValue2 = newValue;
                    showAdress();
                  },
                  items: state.level1.children
                      .map<DropdownMenuItem<dvhcvn.Level2>>((value) {
                    return DropdownMenuItem<dvhcvn.Level2>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                decoration: boxBorderWhiteWithGreenLine,
                child: DropdownButton<dvhcvn.Level3>(
                  hint: Text(
                      state.level3.name != ""
                          ? state.level3.name
                          : "- Phường xã -",
                      style: const TextStyle(color: Colors.black)),
                  value: dropdownValue3,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward,
                      size: 18, color: Colors.black),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(),
                  onChanged: (dvhcvn.Level3? newValue) {
                    context
                        .read<AddressBloc>()
                        .add(AddressIdLevel3Selected(item: newValue!));
                    dropdownValue3 = newValue;
                    showAdress();
                  },
                  items: state.level2.children
                      .map<DropdownMenuItem<dvhcvn.Level3>>((value) {
                    return DropdownMenuItem<dvhcvn.Level3>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
            ]);
      });
  showAdress() {
    String tinh = dropdownValue1 != null ? dropdownValue1!.name + "." : "";
    String huyen = dropdownValue2 != null ? dropdownValue2!.name + "," : "";
    String xaPhuong = dropdownValue3 != null ? dropdownValue3!.name + "," : "";
    addressController.text = xaPhuong + huyen + tinh;
  }

  Widget checkBoxWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("Giá cả thỏa thuận"),
        Checkbox(
            value: isNegotiable,
            onChanged: (value) {
              setState(() {
                isNegotiable = value!;
              });
            })
      ],
    );
  }

  Future<void> SaveSalePost(state) async {
    List<String> listImagePath = [];
    try {
      setState(() {
        this.isLoading = true;
      });
      for (int i = 0; i < state.images.value!.length; i++) {
        var a = await _dioProvider.uploadFile(
            state.images.value![i], "image/png", "salepost");
        listImagePath.add(a);
      }
      Response LandPlanningResponse =
          await _dioProvider.dio.post(_dioProvider.salepostcreate,
              data: {
                "title": titleController.text,
                "content": desController.text,
                "address": {
                  "idLevel1": dropdownValue1!.id,
                  "idLevel2": dropdownValue2!.id,
                  "idLevel3": dropdownValue3!.id,
                },
                "isAvailable": true,
                "isNegotiable": isNegotiable,
                "point": {"latitude": 0, "longitude": 0},
                "images": listImagePath,
                "area": areaController.text,
                "cost": priceController.text,
                "createdBy": await widget.userRepo.getUserId(),
                "type": list.indexOf(type),
                "isPrivate": true
              },
              options: Options(headers: {"Content-Type": "application/json"}));

      print(listImagePath);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đăng tin thành công"),
        backgroundColor: AppColors.green,
      ));
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Lỗi : " + e.toString()),
          backgroundColor: AppColors.darkRed,
        ));
        isLoading = false;
      });
    }
  }
}

String? validateMyInputwithLength(String value, int length) {
  if (value.length < length) {
    return "Vui lòng nhập nhiều hơn $length ký tự";
  }
  return null;
}

String? validateNyInputNotEmty(String value) {
  if (value.isEmpty) {
    return "Vui lòng không bỏ trống!";
  }
  return null;
}

String? validateNumber(String value, int length) {
  if (value.length < length) {
    return "Vui lòng nhập nhiều hơn $length ký tự";
  }

  return null;
}

String? validateAdress(String value) {
  if (value.isEmpty) {
    return "Vui lòng chọn địa chỉ";
  }
  return null;
}

class _ImageInput extends StatelessWidget {
  addImage(BuildContext context, List<String>? images) async {
    var x = await ImagePicker().pickMultiImage(imageQuality: 5);

    if (x != null) {
      for (int i = 0; i < x.length; i++) {}

      List<String> result = [];
      for (int i = 0; i < x.length; i++) {
        result.add(x[i].path.toString());
      }
      if (images != null) {
        result.addAll(images);
      }
      dynamic l = result.toSet();
      l = l.toList();
      print({l});

      context.read<SalePostBloc>().add(SalePostImageChanged(l));
    }
  }

  List<XFile> file = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalePostBloc, SalePostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: boxBorderGray,
              child: (state.images.value != null && state.images.value != [])
                  ? GridView.builder(
                      itemCount: state.images.value!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20),
                      itemBuilder: (_, index) {
                        return Container(
                            child: Stack(children: [
                          Container(
                            height: 120.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    FileImage(File(state.images.value![index])),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                  child: Icon(Icons.cancel),
                                  onTap: () {
                                    List<String> images = state.images.value!;
                                    images.remove(images[index]);
                                    List<String> result = [];
                                    for (int i = 0; i < images.length; i++) {
                                      result.add(images[i].toString());
                                    }
                                    print(state.images.value!.length);
                                    context
                                        .read<SalePostBloc>()
                                        .add(SalePostImageChanged(result));
                                  }))
                        ]));
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              onPressed: () async {
                                addImage(context, state.images.value);
                              },
                              icon: const Icon(
                                Icons.add_to_photos,
                                color: AppColors.appGreen1,
                                size: 35,
                              )),
                          const Text(
                            "Ảnh minh họa",
                            style: textMediumGreen,
                          )
                        ],
                      ),
                    ),
            ),
            Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                  onTap: () {
                    addImage(context, state.images.value);
                  },
                  child: const Icon(EvaIcons.plusCircle,
                      color: AppColors.appGreen1, size: 30),
                ))
          ]),
        );
      },
    );
  }
}
