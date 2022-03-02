import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:maico_land/bloc/news_add_bloc/news_add_bloc.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/label_widget.dart';
import 'package:maico_land/presentation/widgets/widget_input_text.dart';
import 'package:maico_land/presentation/widgets/widget_input_text_field.dart';

class NewsAddScreen extends StatefulWidget {
  const NewsAddScreen({Key? key}) : super(key: key);

  @override
  _NewsAddScreenState createState() => _NewsAddScreenState();
}

class _NewsAddScreenState extends State<NewsAddScreen> {
  String? imagePath;
  List<String> hashTags = [];
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  // final imagePath = TextEditingController();
  var _hashTag = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        child: BlocBuilder<NewsAddBloc, NewsAddState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleInput(titleController),
                    const SizedBox(height: 10),
                    _ContentInput(contentController),
                    const SizedBox(height: 10),
                    Text("Ảnh minh hoạ",
                        style: TextStyle(
                            fontSize: 10, color: AppColors.appGreen1)),
                    IconButton(
                        onPressed: () async {
                          var result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowMultiple: false,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          if (result == null) return;
                          final file = result.files.first;
                          print(file.path);
                          // openFile(file);
                        },
                        icon: Icon(Icons.add)),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: AppColors.appGreen1,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Text("Đăng"))
                  ],
                ),
              );
            }),
      ),
    );
  }

  // void openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }

  @override
  void dispose() {
    super.dispose();
  }

  Future selectImage() async {
    var file = await PickFile().pickImage(context);
    setState(() {
      imagePath = file;
    });
  }

  Widget _ImageInput(context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: Row(
            children: [
              const LabelWidget(label: "Ảnh minh họa"),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  await selectImage();
                  context
                      .read<NewsAddBloc>()
                      .add(NewsAddImageChanged(imagePath!));
                },
              )
            ],
          )),
          imagePath != null
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(File(imagePath!), fit: BoxFit.cover)

                  // child: ,
                  )
              : Text('Chưa có ảnh minh họa ',
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
          const SizedBox(height: 10),
        ]);
      },
    );
  }

  Widget _HashTagInput(context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.hashTag != current.hashTag,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const LabelWidget(label: "HashTag"),
          TextField(
            controller: _hashTag,
            key: const Key('NewsAddForm_hashTagInput_textField'),
            decoration: InputDecoration(
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
                  print(hashTags);
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
        return Chip(
            backgroundColor: AppColors.appGreen2,
            label: Text(items[index]),
            labelStyle: TextStyle(color: Colors.white),
            onDeleted: () {
              setState(() {
                items.remove(items[index]);
              });
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

class _TitleInput extends StatelessWidget {
  _TitleInput(this.controller);
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
                errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
                focusColor: AppColors.appGreen1,
                contentPadding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                  right: 10.0,
                )),
            validator: (value) {
              if (state.content.invalid || value == null || value.isEmpty) {
                return 'Vui lòng nhập trên 10 kí tự !';
              }
              return null;
            },
          )
        ]);
      },
    );
  }
}

class _ContentInput extends StatelessWidget {
  _ContentInput(this.controller);
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
              errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
              focusColor: AppColors.appGreen1,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              errorText: state.content.invalid
                  ? 'Vui lòng nhập trên 10 kí tự !'
                  : null,
            ),
          )
        ]);
      },
    );
  }
}

class _NewsAddButton extends StatelessWidget {
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
                  print("lưn");
                  try {
                    // if (state.image!="https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2Fnews_default_image.png?alt=media&token=c18a786d-edc2-42f7-bf06-878906c85320"){
                    //     var imageUrl = await Storage.storageImage(context,File(state.image));
                    //   context.read<NewsAddBloc>().add(NewsAddImageChanged(imageUrl));
                    //   }
                  } catch (e) {}

                  try {
                    print(state.image);
                    print(state.content);

                    context.read<NewsAddBloc>().add(NewsAddSubmitted());
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
                      SnackBar(
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
