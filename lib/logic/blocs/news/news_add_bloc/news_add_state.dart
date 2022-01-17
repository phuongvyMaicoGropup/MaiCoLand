part of 'news_add_bloc.dart'; 


class NewsAddState extends Equatable {
  const NewsAddState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.image ,
    this.pdfContent,
    this.hashTag  ,
    this.status = FormzStatus.pure,
  });

  final Title title;
  final Content content; 
  final File? image; 
  final File? pdfContent ;
  final List<String>? hashTag ; 
  final FormzStatus status;

  @override
  List<Object> get props => [title, content ,status];

  NewsAddState copyWith({
    Title? title , 
    Content? content,
    File? image,
    File? pdfContent,
    List<String>? hashTag,
    FormzStatus? status,
  }) {
    return NewsAddState(
      title : title?? this.title,
      content : content?? this.content,
      image : image?? this.image,
      pdfContent: pdfContent?? this.pdfContent,
      hashTag : hashTag?? this.hashTag,
      status: status ?? this.status,
    );
  }
}