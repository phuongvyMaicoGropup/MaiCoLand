import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:maico_land/bloc/news_add_bloc/news_add_bloc.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class NewsAddScreen extends StatefulWidget {
  const NewsAddScreen({required this.type, Key? key}) : super(key: key);
  final int type;
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
  final _hashTag = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(imagePath);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Đăng tin",
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
                _TitleInput(titleController),
                const SizedBox(height: 15),
                _ContentInput(contentController),
                const SizedBox(height: 15),
                _HashTagInput(context),
                _ImageInput(),
                _NewsAddButton(widget.type),
              ],
            ),
          )),
    );
  }

  Widget _HashTagInput(context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.hashTag != current.hashTag,
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
              errorText:
                  state.title.invalid ? 'Vui lòng nhập trên 10 kí tự !' : null,
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
      // buildWhen: (previous, current) => previous.hashTag != current.hashTag,
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
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: Row(
            children: [
              const Text("Ảnh minh hoạ",
                  style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  var file = await PickFile().pickImage(context);

                  context.read<NewsAddBloc>().add(NewsAddImageChanged(file));
                },
              )
            ],
          )),
          state.image !=
                  "https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2Fnews_default_image.png?alt=media&token=c18a786d-edc2-42f7-bf06-878906c85320"
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(File(state.image), fit: BoxFit.cover)

                  // child: ,
                  )
              : WidgetSkeleton(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
        ]);
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
      buildWhen: (previous, current) => previous.content != current.content,
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
  _NewsAddButton(this.type);
  final int type;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('NewsAddForm_continue_raisedButton'),
          child: const Text('Lưu', style: TextStyle(color: Colors.white)),
          onPressed: state.status.isValidated
              ? () async {
                  try {
                    context.read<NewsAddBloc>().add(NewsAddSubmitted(type));
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/", (route) => false);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Đăng bài thành công"),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
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
        );
      },
    );
  }
}
