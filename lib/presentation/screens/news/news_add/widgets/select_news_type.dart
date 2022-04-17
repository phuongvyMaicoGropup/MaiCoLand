import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class SelectNewsType extends StatefulWidget {
  const SelectNewsType({Key? key}) : super(key: key);

  @override
  State<SelectNewsType> createState() => _SelectNewsTypeState();
}

class _SelectNewsTypeState extends State<SelectNewsType> {
  String newsType = "Thị trường";

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: ListView(shrinkWrap: true, children: [
        Center(
          child: Text("Chọn loại tin tức",
              style: mediumText.copyWith(
                  fontSize: 16, color: const Color.fromARGB(255, 70, 126, 83))),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 13),
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6DC882),
            border: Border.all(
                color: const Color(0xFF6DC882),
                width: 1.0,
                style: BorderStyle.solid), //Border.all
            /*** The BorderRadius widget  is here ***/
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ), //BorderRadius.
          ),
          child: DropdownButton<String>(
            value: newsType,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: AppColors.black),
            isExpanded: true,
            iconEnabledColor: Colors.white,
            dropdownColor: const Color(0xFF6DC882),
            underline: Container(),
            focusColor: const Color.fromARGB(255, 70, 126, 83),
            onChanged: (String? value) {
              setState(() {
                newsType = value!;
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
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
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Huỷ",
                  style: textMiniBlack,
                )),
            TextButton(
                onPressed: () {
                  int type = 0;
                  if (newsType == "Chính sách") {
                    type = 1;
                  } else if (newsType == "Quy hoạch") {
                    type = 2;
                  }
                  Navigator.of(context).pushNamed('/news/add', arguments: type);
                },
                child: const Text(
                  "Tiếp tục",
                  style: textMiniBlack,
                )),
          ],
        )
      ]),
      padding: const EdgeInsets.all(16.0),
    );
  }
}
