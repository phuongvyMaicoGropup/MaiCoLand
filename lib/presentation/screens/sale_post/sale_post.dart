import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_location_picker/open_location_picker.dart';

class SalePostScreen extends StatefulWidget {
  SalePostScreen({Key? key}) : super(key: key);

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
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ScrollController bottomsheetcon = ScrollController();
  String type = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng tin"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
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
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              OpenMapPicker(
                decoration: const InputDecoration(hintText: "My location"),
                onSaved: (FormattedLocation? newValue) {
                  /// save new value
                },
              ),
              sizebox(),
              areaWidget(),
              sizebox(),
              priceWidget(),
              sizebox(),
              descriptionWidget(),
            ],
          ),
        ),
      )),
    );
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
                controller: areaController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
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
                controller: priceController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
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
}
