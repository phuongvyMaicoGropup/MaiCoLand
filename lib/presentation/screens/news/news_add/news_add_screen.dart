import 'dart:io';

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
            _PdfContentInput(),
              
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
  Widget _PdfContentInput(){
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      buildWhen: (previous, current) =>
          previous.pdfContent != current.pdfContent,
      builder: (context, state) {
        return Column(children: [
          Container(
              child: Row(
            children: [
              const LabelWidget(label: "Chọn tệp văn bản (pdf)"),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  setState(() async{

                  pdfContentPath = await PickFile().pickFilePdf(context);
                  }); 
                  String name = pdfContentPath.toString();
                context
                      .read<NewsAddBloc>()
                      .add(NewsAddPdfContentChanged(pdfContentPath!));
                  print("state " + state.pdfContent.toString());
                },
              )
            ],
          )),
          pdfContentPath != null
              ? Text(pdfContentPath.toString())
              : Container()
        ]);
      },
    );
  }
  
   Future selectImage() async {
    var file = await PickFile().pickImage(context);
      setState(() async{
                 imagePath = file ;    
                  }); 

   
  }

  
  Widget _ImageInput(){
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
                  
                  selectImage();
                  context
                      .read<NewsAddBloc>()
                      .add(NewsAddImageChanged(imagePath!));
                },
              )
            ],
          )),
           Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: imagePath != null
                    ? Image.file(imagePath!, fit: BoxFit.cover)
                    : const Center(
                        child: Text('Chọn ảnh'),
                      ),
                // child: ,
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
          LabelWidget(label: "Tiêu đề "),
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

// class _ImageInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    
//     return BlocBuilder<NewsAddBloc, NewsAddState>(
//        buildWhen: (previous, current) => previous.image != current.image,
//       builder: (context, state) {
//         return Column(children: [
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
//                   imagePath = await PickFile().pickImage(context);
//                   print(imagePath.toString());
//                   String name = imagePath.toString();
//                   context
//                       .read<NewsAddBloc>()
//                       .add(NewsAddImageChanged(imagePath!));
//                 },
//               )
//             ],
//           )),
//           imagePath != null ? Text(imagePath.toString()) : Container()
//         ]);
//       },
//     );
//   }
// }

// class _PdfContentInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     File? pdfContentPath;
//     return BlocBuilder<NewsAddBloc, NewsAddState>(
//       buildWhen: (previous, current) =>
//           previous.pdfContent != current.pdfContent,
//       builder: (context, state) {
//         return Column(children: [
//           Container(
//               child: Row(
//             children: [
//               const LabelWidget(label: "Chọn tệp văn bản (pdf)"),
//               IconButton(
//                 icon: Icon(
//                   Icons.add,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 onPressed: () async {
//                   pdfContentPath = await PickFile().pickFilePdf(context);
//                   String name = pdfContentPath.toString();
//                 context
//                       .read<NewsAddBloc>()
//                       .add(NewsAddPdfContentChanged(pdfContentPath!));
//                   print("state " + state.pdfContent.toString());
//                 },
//               )
//             ],
//           )),
//           pdfContentPath != null
//               ? Text(pdfContentPath.toString())
//               : Container()
//         ]);
//       },
//     );
//   }
// }

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
