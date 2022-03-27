part of 'news_add_bloc.dart';

class NewsAddState extends Equatable {
  const NewsAddState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.image = const PathImage.pure(),
    this.hashTag = "",
    this.status = FormzStatus.pure,
  });

  final Title title;
  final Content content;
  final PathImage image;
  // final File? pdfContent ;
  final String hashTag;
  final FormzStatus status;

  @override
  List<Object> get props => [title, content, status, image, hashTag];

  NewsAddState copyWith({
    Title? title,
    Content? content,
    PathImage? image,
    String? hashTag,
    FormzStatus? status,
  }) {
    return NewsAddState(
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      hashTag: hashTag ?? this.hashTag,
      status: status ?? this.status,
    );
  }
}
