import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:land_app/helpers/pick_file.dart';
import 'package:land_app/helpers/storage.dart';
import 'package:land_app/logic/blocs/news/news_add_bloc/news_add_bloc.dart';
import 'package:land_app/presentation/common_widgets/widgets.dart';
import 'package:land_app/presentation/resources/resources.dart';

class NewsAddScreen extends StatefulWidget {
  const NewsAddScreen({Key? key}) : super(key: key);

  @override
  _NewsAddScreenState createState() => _NewsAddScreenState();
}

class _NewsAddScreenState extends State<NewsAddScreen> {
  String? imagePath;
  PDFDocument? doc;
  List<String> hashTags=[];
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
        child: Column(
          children: [
            _TitleInput(),
            _ContentInput(),
            _ImageInput(context),
            _HashTagInput(),
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


  Future selectImage() async {
    var file = await PickFile().pickImage(context);
    setState(() {
      imagePath = file;
    });
  }

  Widget _ImageInput(context) {
    return BlocBuilder<NewsAddBloc, NewsAddState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  
                  width: MediaQuery.of(context).size.width ,
                  child: Image.file(File(imagePath!), fit: BoxFit.cover)

                  // child: ,
                  )
              :  Text('Chưa có ảnh minh họa ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
          const SizedBox(height : 10),
              
        ]);
      },
    );
  }

  Widget _HashTagInput(){
    
    return BlocBuilder<NewsAddBloc, NewsAddState>(
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
                  
                  if(_hashTag.text !="") {
                    setState((){
                  hashTags.add(_hashTag.text);
                  });
                    context
                      .read<NewsAddBloc>()
                      .add(NewsAddHashTagChanged(hashTags));
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
  Widget _HashTagChip(List<String> items){
    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, index) {
              return  Chip(
  backgroundColor: AppColors.appGreen2,
  label:  Text(items[index]),
  labelStyle: TextStyle (color : Colors.white),
  onDeleted : (){
    setState((){
      items.remove(items[index]); 
    });
  }
); },
      itemCount: items.length,
       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80,
                childAspectRatio: 5 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 0),); 
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
          const LabelWidget(label: "Nội dung"),
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
              ? () async{
                print("lưn");
                  try {
                    print(state.image);
                    print(state.content);
                    if (state.image!="https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2Fnews_default_image.png?alt=media&token=c18a786d-edc2-42f7-bf06-878906c85320"){
                      var imageUrl = await Storage.storageImage(context,File(state.image));
                    context.read<NewsAddBloc>().add(NewsAddImageChanged(imageUrl));
                    }
                    
                    context.read<NewsAddBloc>().add(NewsAddSubmitted());
                    Navigator.of(context).pushNamedAndRemoveUntil( "/", (route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: const Text("Đăng bài thành công"),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          );
                  }catch(e){
                     ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Lỗi đăng bài. Vui lòng khởi động lại phần mềm!"),
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
