import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maico_land/bloc/news_add_bloc/news_add_bloc.dart';
import 'package:maico_land/presentation/screens/news/news_add/widgets/widgets.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/styles/app_themes.dart';

class NewsAddScreen extends StatefulWidget {
  const NewsAddScreen({Key? key}) : super(key: key);
  // final int type;
  @override
  _NewsAddScreenState createState() => _NewsAddScreenState();
}

class _NewsAddScreenState extends State<NewsAddScreen> {
  String? imagePath;

  List<String> hashTags = [];
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final hashTagController = TextEditingController();
  // final imagePath = TextEditingController();
  int type = 0;
  final listType = [
    {0: "Thị trường"},
    {1: "Chính sách"},
    {2: "Quy hoạch"},
  ];
  final _hashTag = TextEditingController();
  bool isSubmission = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Tạo tin đăng",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        body: BlocListener<NewsAddBloc, NewsAddState>(
            listener: ((context, state) {
              if (state.status == FormzStatus.submissionInProgress) {
                setState(() {
                  isSubmission = true;
                });
              }
              if (state.status == FormzStatus.submissionFailure ||
                  state.status == FormzStatus.submissionSuccess) {
                setState(() {
                  isSubmission = false;
                });
              }
            }),
            child: _buildContent()));
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return selectType();
      },
    );
  }

  Widget _buildContent() {
    return isSubmission
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // selectType(conte),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: boxBorderDefault,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(listType[type].values.first),
                                GestureDetector(
                                  onTap: () {
                                    _showModalBottomSheet(context);
                                  },
                                  child: Icon(Icons.arrow_downward,
                                      color: Colors.black26),
                                )
                              ])),
                      const SizedBox(height: 15),

                      _TitleInput(titleController),
                      const SizedBox(height: 15),
                      _ContentInput(contentController),
                      const SizedBox(height: 15),
                      _HashTagInput(context),
                      _ImageInput(),
                      _NewsAddButton(type),
                    ],
                  ),
                )),
          );
  }

  Widget selectType() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listType.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                      onTap: () {
                        setState(() {
                          type = listType[index].keys.first;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(listType[index].values.first)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget selectType() {
  //   return Padding(
  //     child: ListView(shrinkWrap: true, children: [
  //       Container(
  //         width: MediaQuery.of(context).size.width,
  //         margin: const EdgeInsets.only(bottom: 13),
  //         padding: const EdgeInsets.only(left: 8, right: 8),
  //         decoration: BoxDecoration(
  //           color: const Color(0xFF6DC882),
  //           border: Border.all(
  //               color: const Color(0xFF6DC882),
  //               width: 1.0,
  //               style: BorderStyle.solid), //Border.all
  //           /*** The BorderRadius widget  is here ***/
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(20),
  //           ), //BorderRadius.
  //         ),
  //         child: DropdownButton<int>(
  //           value: type,
  //           icon: const Icon(Icons.arrow_drop_down),
  //           elevation: 16,
  //           style: const TextStyle(color: AppColors.black),
  //           isExpanded: true,
  //           iconEnabledColor: Colors.white,
  //           dropdownColor: const Color(0xFF6DC882),
  //           underline: Container(),
  //           focusColor: const Color.fromARGB(255, 70, 126, 83),
  //           onChanged: (int? value) {
  //             setState(() {
  //               type = value??0;
  //             });
  //           },
  //           borderRadius: const BorderRadius.all(Radius.circular(15.0)),
  //           items:
  //               listType.map<DropdownMenuItem<int>>((Map<int, String> value) {
  //             return DropdownMenuItem<int>(
  //               value: value.keys.first,
  //               child: Text(value.values.first),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ]),
  //     padding: const EdgeInsets.all(16.0),
  //   );
  // }

  Widget _HashTagInput(context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _hashTag,
            key: const Key('NewsAddForm_hashTagInput_textField'),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: AppColors.appGreen1)),
              labelText: "HashTag",
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorStyle: const TextStyle(fontSize: 10, color: AppColors.red),
              focusColor: AppColors.appGreen1,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_hashTag.text != "") {
                    setState(() {
                      hashTags.add(_hashTag.text);
                    });
                    var hashTagsChange = hashTags.join("/");
                    context
                        .read<NewsAddBloc>()
                        .add(NewsAddHashTagChanged(hashTagsChange));

                    _hashTag.text = "";
                  }
                },
              ),
            ),
          ),
          _HashTagChip(hashTags),
        ]);
      },
    );
  }

  Widget _HashTagChip(List<String> items) {
    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, index) {
        if (items.isEmpty) {
          return Chip(
            backgroundColor: Colors.black.withOpacity(0.04),
            label: const Text("         "),
            labelStyle: const TextStyle(color: Colors.white, fontSize: 10),
          );
        } else {
          return Chip(
              backgroundColor: AppColors.appGreen2,
              label: Text(items[index]),
              labelStyle: const TextStyle(color: Colors.white, fontSize: 10),
              onDeleted: () {
                setState(() {
                  items.remove(items[index]);
                });
              });
        }
      },
      itemCount: items.isNotEmpty ? items.length : 8,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80,
          childAspectRatio: 5 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0),
    );
  }
}

class _HashTagInput extends StatelessWidget {
  _HashTagInput(this.controller);
  final TextEditingController controller;
  List<String> hashTags = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("HashTag",
              style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
          TextField(
            controller: controller,
            key: const Key('NewsAddForm_hashTagInput_textField'),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (controller.text != "") {
                    hashTags.add(controller.text);
                    var hashTagsChange = hashTags.join("/");
                    context
                        .read<NewsAddBloc>()
                        .add(NewsAddHashTagChanged(hashTagsChange));
                    controller.text = "";
                  }
                  print(hashTags);
                },
              ),
            ),
          ),
          _HashTagChip(hashTags, context),
        ]);
      },
    );
  }

  Widget _HashTagChip(List<String> items, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, index) {
        return Chip(
            backgroundColor: AppColors.appGreen2,
            label: Text(items[index]),
            labelStyle: const TextStyle(color: Colors.white),
            onDeleted: () {
              items.remove(items[index]);
            });
      },
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80,
          childAspectRatio: 5 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0),
    );
  }
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

      context.read<NewsAddBloc>().add(NewsAddImageChanged(l));
    }
  }

  List<XFile> file = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
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
                                    context
                                        .read<NewsAddBloc>()
                                        .add(NewsAddImageChanged(result));
                                  })),
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
                  child: Icon(EvaIcons.plusCircle,
                      color: AppColors.appGreen1, size: 30),
                ))
          ]),
        );
      },
    );
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            key: const Key('NewsAddForm_titleInput_textField'),
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) =>
                context.read<NewsAddBloc>().add(NewsAddTitleChanged(value)),
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: AppColors.appGreen1)),
                labelText: "Tiêu đề",
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: AppColors.red)),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: AppColors.red)),
                errorStyle: const TextStyle(fontSize: 10, color: AppColors.red),
                focusColor: AppColors.appGreen1,
                errorText: state.title.invalid
                    ? 'Vui lòng nhập trên 10 kí tự !'
                    : null,
                contentPadding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                  right: 10.0,
                )),
          )
        ]);
      },
    );
  }
}

class _ContentInput extends StatelessWidget {
  const _ContentInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            key: const Key('NewsAddForm_contentInput_textField'),
            maxLines: 10,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) =>
                context.read<NewsAddBloc>().add(NewsAddContentChanged(value)),
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: AppColors.appGreen1)),
              labelText: "Nội dung",
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorStyle: const TextStyle(fontSize: 10, color: AppColors.red),
              focusColor: AppColors.appGreen1,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              errorText: state.content.invalid
                  ? 'Vui lòng nhập trên 20 kí tự !'
                  : null,
            ),
          )
        ]);
      },
    );
  }
}

class _NewsAddButton extends StatelessWidget {
  const _NewsAddButton(this.type);
  final int type;
  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsAddBloc, NewsAddState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Đăng bài thành công"),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          context.read<NewsAddBloc>().add(NewsAddInitial());
        }
      },
      child: BlocBuilder<NewsAddBloc, NewsAddState>(
        builder: (context, state) {
          print("_NewsAddButton" + state.status.toString());
          if (state.status == FormzStatus.submissionInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const Key('NewsAddForm_continue_raisedButton'),
              child: const Text('Lưu', style: TextStyle(color: Colors.white)),
              onPressed: state.status.isValidated
                  ? () async {
                      try {
                        context.read<NewsAddBloc>().add(NewsAddSubmitted(type));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Lỗi đăng bài. Vui lòng khởi động lại phần mềm!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        print(e.toString());
                      }
                    }
                  : null,
            ),
          );
        },
      ),
    );
  }
}
