import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/news_add_bloc/news_add_bloc.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/label_widget.dart';
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
                    // LabelWidget(label: "Tiêu đề"),
                    textFormField(
                        EvaIcons.activity, "Tiêu đề", titleController, 1),
                    const SizedBox(height: 10),
                    // LabelWidget(label: "Nội dung"),
                    textFormField(
                        EvaIcons.activity, "Nội dung", contentController, 8),

                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     child: _NewsAddButton()),

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

  @override
  void dispose() {
    super.dispose();
  }

  Widget textFormField(IconData icon, String labelText,
      TextEditingController controller, int maxLines) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      controller: controller,
      autofocus: true,
      
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
          labelText: labelText,
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
        if (value == null || value.isEmpty) {
          return 'Vui lòng không được để trống!';
        }
        return null;
      },
    );
  }
}
  // Future selectImage() async {
  //   var file = await PickFile().pickImage(context);
  //   setState(() {
  //     imagePath = file;
  //   });
  // }

//   Widget _ImageInput(context) {
//     return BlocBuilder<NewsAddBloc, NewsAddState>(
//       buildWhen: (previous, current) => previous.image != current.image,
//       builder: (context, state) {
//         return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(
//               child: Row(
//             children: [
//               const LabelWidget(label: "Ảnh minh họa"),
//               IconButton(
//                 icon: Icon(
//                   Icons.add,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 onPressed: () async {
//                   await selectImage();
//                   context
//                       .read<NewsAddBloc>()
//                       .add(NewsAddImageChanged(imagePath!));
//                 },
//               )
//             ],
//           )),
//           imagePath != null
//               ? Container(
//                   margin: const EdgeInsets.symmetric(vertical: 20),
//                   width: MediaQuery.of(context).size.width,
//                   child: Image.file(File(imagePath!), fit: BoxFit.cover)

//                   // child: ,
//                   )
//               : Text('Chưa có ảnh minh họa ',
//                   style: TextStyle(color: Theme.of(context).colorScheme.error)),
//           const SizedBox(height: 10),
//         ]);
//       },
//     );
//   }

//   Widget _HashTagInput(context) {
//     return BlocBuilder<NewsAddBloc, NewsAddState>(
//       buildWhen: (previous, current) => previous.hashTag != current.hashTag,
//       builder: (context, state) {
//         return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const LabelWidget(label: "HashTag"),
//           TextField(
//             controller: _hashTag,
//             key: const Key('NewsAddForm_hashTagInput_textField'),
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: () {
//                   if (_hashTag.text != "") {
//                     setState(() {
//                       hashTags.add(_hashTag.text);
//                     });
//                     var hashTagsChange = hashTags.join("/");
//                     context
//                         .read<NewsAddBloc>()
//                         .add(NewsAddHashTagChanged(hashTagsChange));
//                     _hashTag.text = "";
//                   }
//                   print(hashTags);
//                 },
//               ),
//             ),
//           ),
//           _HashTagChip(hashTags),
//         ]);
//       },
//     );
//   }

//   Widget _HashTagChip(List<String> items) {
//     return GridView.builder(
//       shrinkWrap: true,
//       itemBuilder: (BuildContext ctx, index) {
//         return Chip(
//             backgroundColor: AppColors.appGreen2,
//             label: Text(items[index]),
//             labelStyle: TextStyle(color: Colors.white),
//             onDeleted: () {
//               setState(() {
//                 items.remove(items[index]);
//               });
//             });
//       },
//       itemCount: items.length,
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 80,
//           childAspectRatio: 5 / 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 0),
//     );
//   }
// }
