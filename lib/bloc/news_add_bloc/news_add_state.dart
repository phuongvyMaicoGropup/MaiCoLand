part of 'news_add_bloc.dart'; 


class NewsAddState extends Equatable {
  const NewsAddState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.image ="https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2Fnews_default_image.png?alt=media&token=c18a786d-edc2-42f7-bf06-878906c85320",
    this.hashTag ="",
    this.status = FormzStatus.pure,
  });

  final Title title;
  final Content content; 
  final String image; 
  // final File? pdfContent ;
  final String hashTag ; 
  final FormzStatus status;

  @override
  List<Object> get props => [title, content ,status,image,hashTag];

  NewsAddState copyWith({
    Title? title , 
    Content? content,
    String? image,
    String? hashTag,
    FormzStatus? status,
  }) {
    return NewsAddState(
      title : title?? this.title,
      content : content?? this.content,
      image : image?? this.image,
      hashTag : hashTag?? this.hashTag,
      status: status ?? this.status,
    );
  }
}