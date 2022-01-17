import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:land_app/helpers/pick_file.dart';
import 'package:land_app/logic/blocs/news/news_add_bloc/news_add_bloc.dart';
import 'package:land_app/presentation/common_widgets/widgets.dart';

class NewsAddScreen extends StatefulWidget {
  const NewsAddScreen({Key? key}) : super(key: key);

  @override
  _NewsAddScreenState createState() => _NewsAddScreenState();
}

class _NewsAddScreenState extends State<NewsAddScreen> {
  File? imagePath;
  File? pdfContentPath;
  PDFDocument? doc;
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
        child: Column(
          children: <Widget>[
            _TitleInput(),
            _ContentInput(),
            _ImageInput(),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _NewsAddButton()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future selectPdfFile() async {
  //   var file = await PickFile().pickFilePdf(context);
  //   setState(() {
  //     pdfContentPath = file;
  //   });
  //   setState(() async{
  //     doc = await PDFDocument.fromFile(file);
  //   });
    
  // }

  // Widget _PdfContentInput() {
  //   return BlocBuilder<NewsAddBloc, NewsAddState>(
  //     buildWhen: (previous, current) =>
  //         previous.pdfContent != current.pdfContent,
  //     builder: (context, state) {
  //       return Column(children: [
  //         Container(
  //             child: Row(
  //           children: [
  //             const LabelWidget(label: "Chọn tệp văn bản (pdf)"),
  //             IconButton(
  //               icon: Icon(
  //                 Icons.add,
  //                 color: Theme.of(context).colorScheme.primary,
  //               ),
  //               onPressed: () async {
  //                 setState(() async {
  //                   await selectPdfFile();

  //                 });

                   
  //                 context
  //                     .read<NewsAddBloc>()
  //                     .add(NewsAddPdfContentChanged(pdfContentPath!));
  //                 print("state " + state.pdfContent.toString());
  //               },
  //             )
  //           ],
  //         )),
  //         pdfContentPath != null
  //             ? Center(child: PDFViewer(document: doc!),)
  //             : Text("Trống")
  //       ]);
  //     },
  //   );
  // }

  Future selectImage() async {
    var file = await PickFile().pickImage(context);
    setState(() {
      imagePath = file;
    });
  }

  Widget _ImageInput() {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      builder: (context, state) {
        return Column(children: [
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
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.file(imagePath!, fit: BoxFit.cover)

                  // child: ,
                  )
              : Center(
                  child: Text('Chưa có ảnh minh họa ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                ),
        ]);
      },
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const LabelWidget(label: "Tiêu đề "),
          TextField(
            key: const Key('NewsAddForm_titleInput_textField'),
            onChanged: (title) =>
                context.read<NewsAddBloc>().add(NewsAddTitleChanged(title)),
            decoration: InputDecoration(
              errorText: state.title.invalid
                  ? 'Tiêu đề không được dưới 10 kí tự '
                  : null,
            ),
          )
        ]);
      },
    );
  }
}

class _ContentInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) => previous.content != current.content,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LabelWidget(label: "Nội dung"),
          TextField(
            key: const Key('NewsAddForm_contentInput_textField'),
            maxLines: 10,
            onChanged: (content) =>
                context.read<NewsAddBloc>().add(NewsAddContentChanged(content)),
            decoration: InputDecoration(
              errorText: state.content.invalid
                  ? 'Nội dung không được dưới 10 kí tự '
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
              ? () {
                  context.read<NewsAddBloc>().add(NewsAddSubmitted());
                }
              : null,
        );
      },
    );
  }
}
