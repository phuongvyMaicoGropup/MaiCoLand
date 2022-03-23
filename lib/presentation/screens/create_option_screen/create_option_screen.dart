import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/address_bloc/address.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

class CreateOption {
  final String title;
  final String description;
  final IconData icon;

  CreateOption(this.title, this.description, this.icon);
}

class CreateOptionScreen extends StatefulWidget {
  CreateOptionScreen({Key? key}) : super(key: key);

  @override
  State<CreateOptionScreen> createState() => _CreateOptionScreenState();
}

class _CreateOptionScreenState extends State<CreateOptionScreen> {
  List<CreateOption> createOptions = [
    CreateOption(
      "Đăng tin tức",
      "Đăng tin tức bất động sản / quy hoạch đất / thị trường ",
      Icons.newspaper_outlined,
    ),
    CreateOption(
      "Đăng bản đồ quy hoạch",
      "Đăng bản đồ quy hoạch sử dụng đất/ dự án ",
      Icons.map_outlined,
    )
  ];
  String newsType = 'Thị trường';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Đăng tin"),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                TextButton(
                  onPressed: () => selectNewsType(context),
                  // Navigator.of(context).pushNamed("/news/add"),
                  child: OptionCard(
                    item: CreateOption(
                      "Đăng tin tức",
                      "Đăng tin tức bất động sản / quy hoạch đất / thị trường ",
                      Icons.newspaper_outlined,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    selectAddress(context);
                    // Address a = Address("", "", "");
                    // Navigator.of(context)
                    //     .pushNamed("/landplanning/add", arguments: a);
                  },
                  child: OptionCard(
                    item: CreateOption(
                      "Đăng bản đồ quy hoạch",
                      "Đăng bản đồ quy hoạch sử dụng đất/ dự án  ",
                      Icons.map_outlined,
                    ),
                  ),
                )
              ],
            )));
  }

  selectNewsType(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              child: ListView(shrinkWrap: true, children: [
                Center(
                  child: Text("Chọn đăng loại tin tức", style: minorText),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 13),
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: AppColors.gray.withOpacity(0.1),
                    border: Border.all(
                        color: AppColors.gray.withOpacity(0.5),
                        width: 1.0,
                        style: BorderStyle.solid), //Border.all
                    /*** The BorderRadius widget  is here ***/
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ), //BorderRadius.
                  ),
                  child: DropdownButton<String>(
                    value: newsType,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: AppColors.appGreen2),
                    isExpanded: true,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        newsType = newValue!;
                      });
                    },
                    items: <String>['Thị trường', 'Chính sách', 'Quy hoạch']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: const Text("Huỷ")),
                    TextButton(
                        onPressed: () {
                          int type = 0;
                          if (newsType == "Chính sách")
                            type = 1;
                          else if (newsType == "Quy hoạch") type = 2;
                          Navigator.of(context)
                              .pushNamed('/news/add', arguments: type);
                        },
                        child: const Text("Tiếp tục")),
                  ],
                )
              ]),
              padding: const EdgeInsets.all(8.0),
            ),
          );
        });
  }

  selectAddress(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          // final data = AddressData.of(context, listen: false);
          // dvhcvn.Entity entity = data.level3;
          // entity ??= data.level2;
          // entity ??= data.level1;

          return Dialog(
            child: Padding(
              child: BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                return SelectAddress();
              }),
              padding: const EdgeInsets.all(8.0),
            ),
          );
        });
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({required this.item, Key? key}) : super(key: key);

  final CreateOption item;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: AppColors.appGreen2, shape: BoxShape.circle),
                  child: Icon(item.icon, size: 30, color: Colors.white))),
          const SizedBox(width: 10),
          Expanded(
              flex: 8,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: mediumText),
                    const SizedBox(height: 4),
                    Text(item.description, style: descriptionText)
                  ]))
        ],
      ),
    ));
  }
}

class SelectAddress extends StatelessWidget {
  dvhcvn.Level1? dropdownValue1;
  dvhcvn.Level2? dropdownValue2;
  dvhcvn.Level3? dropdownValue3;
  @override
  Widget build(BuildContext _) => BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              Center(
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text("Thêm bản đồ mới", style: mediumText))),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 13),
                padding: const EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.1),
                  border: Border.all(
                      color: AppColors.gray.withOpacity(0.5),
                      width: 1.0,
                      style: BorderStyle.solid), //Border.all
                  /*** The BorderRadius widget  is here ***/
                  borderRadius: const BorderRadius.all(
                    Radius.circular(2),
                  ), //BorderRadius.
                ),
                child: DropdownButton<dvhcvn.Level1>(
                  alignment: AlignmentDirectional.centerStart,
                  hint: Text(state.level1.name != ""
                      ? state.level1.name
                      : "- Tỉnh thành -"),
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  // elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  isExpanded: true,

                  underline: Container(),
                  onChanged: (dvhcvn.Level1? newValue) {
                    context
                        .read<AddressBloc>()
                        .add(AddressIdLevel1Selected(item: newValue!));

                    print(newValue);
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
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.1),
                  border: Border.all(
                      color: AppColors.gray.withOpacity(0.5),
                      width: 1.0,
                      style: BorderStyle.solid), //Border.all
                  /*** The BorderRadius widget  is here ***/
                  borderRadius: const BorderRadius.all(
                    Radius.circular(2),
                  ), //BorderRadius.
                ),
                child: DropdownButton<dvhcvn.Level2>(
                  hint: Text(state.level2.name != ""
                      ? state.level2.name
                      : "- Quận huyện -"),
                  isExpanded: true,
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(),
                  onChanged: (dvhcvn.Level2? newValue) {
                    context
                        .read<AddressBloc>()
                        .add(AddressIdLevel2Selected(item: newValue!));
                    print(newValue);
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
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.1),
                  border: Border.all(
                      color: AppColors.gray.withOpacity(0.5),
                      width: 1.0,
                      style: BorderStyle.solid), //Border.all
                  /*** The BorderRadius widget  is here ***/
                  borderRadius: const BorderRadius.all(
                    Radius.circular(2),
                  ), //BorderRadius.
                ),
                child: DropdownButton<dvhcvn.Level3>(
                  hint: Text(state.level3.name != ""
                      ? state.level3.name
                      : "- Phường xã -"),
                  value: dropdownValue3,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(),
                  onChanged: (dvhcvn.Level3? newValue) {
                    context
                        .read<AddressBloc>()
                        .add(AddressIdLevel3Selected(item: newValue!));
                    print(newValue);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {}, child: const Text("Huỷ")),
                  TextButton(
                      onPressed: (state.level1.id != "" &&
                              state.level2.id != "" &&
                              state.level3.id != "")
                          ? () {
                              context.read<AddressBloc>().add(AddressInitial());
                              Navigator.of(context).pushNamed(
                                  "/landplanning/add",
                                  arguments: Address(state.level1.id,
                                      state.level2.id, state.level3.id));
                            }
                          : null,
                      child: const Text("Tiếp tục")),
                ],
              )
            ]);
      });
}
