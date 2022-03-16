import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/address_bloc/address.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/model/entities/address_data.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class CreateOption {
  final String title;
  final String description;
  final IconData icon;

  CreateOption(this.title, this.description, this.icon);
}

class CreateOptionScreen extends StatelessWidget {
  CreateOptionScreen({Key? key}) : super(key: key);

  List<CreateOption> createOptions = [
    CreateOption(
      "Đăng tin tức",
      "Đăng tin tức bất động sản / quy hoạch đất / thị trường ",
      Icons.newspaper_outlined,
    ),
    CreateOption(
      "Đăng bản đồ quy hoạch",
      "Đăng bản đồ quy hoạch sử dụng đất/ dự án  ",
      Icons.map_outlined,
    )
  ];
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
                  onPressed: () => Navigator.of(context).pushNamed("/news/add"),
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

  // Level1? selectLevel1;
  // Widget level() {
  //   return ListView.builder(itemBuilder: (context, index) {
  //     return TextButton(
  //         onPressed: () {},
  //         child: ListTile(title: Text(dvhcvn.level1s[index].name)));
  //   });
  // }
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.appGreen2, shape: BoxShape.circle),
                  child: Icon(item.icon, size: 30, color: Colors.white))),
          const SizedBox(width: 10),
          Expanded(
              flex: 8,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: mediumText),
                    SizedBox(height: 4),
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
              const Center(child: Text("Thêm bản đồ mới", style: mediumText)),
              DropdownButton<dvhcvn.Level1>(
                hint: Text(state.level1.name != ""
                    ? state.level1.name
                    : "- Tỉnh thành -"),
                value: dropdownValue1,
                icon: const Icon(Icons.arrow_downward, size: 18),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
              DropdownButton<dvhcvn.Level2>(
                hint: Text(state.level2.name != ""
                    ? state.level2.name
                    : "- Quận huyện -"),
                value: dropdownValue2,
                icon: const Icon(Icons.arrow_downward, size: 18),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
              DropdownButton<dvhcvn.Level3>(
                hint: Text(state.level3.name != ""
                    ? state.level3.name
                    : "- Phường xã -"),
                value: dropdownValue3,
                icon: const Icon(Icons.arrow_downward, size: 18),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
              Row(
                children: [
                  TextButton(onPressed: () {}, child: Text("Huỷ")),
                  TextButton(
                      onPressed: (state.level1.id != "" &&
                              state.level2.id != "" &&
                              state.level3.id != "")
                          ? () {
                              Navigator.of(context).pushNamed(
                                  "/landplanning/add",
                                  arguments: Address(state.level1.id,
                                      state.level2.id, state.level3.id));
                            }
                          : null,
                      child: Text("Tiếp tục")),
                ],
              )
            ]);
      });
}
