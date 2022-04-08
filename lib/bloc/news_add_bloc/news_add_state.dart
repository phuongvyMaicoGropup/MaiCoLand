part of 'news_add_bloc.dart';

class NewsAddState extends Equatable {
  const NewsAddState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.images = const PathImage.pure(),
    this.hashTag = "",
    this.status = FormzStatus.pure,
  });

  final Title title;
  final Content content;
  final PathImage images;
  // final File? pdfContent ;
  final String hashTag;
  final FormzStatus status;

  @override
  List<Object> get props => [title, content, status, images, hashTag];

  NewsAddState copyWith({
    Title? title,
    Content? content,
    PathImage? images,
    String? hashTag,
    FormzStatus? status,
  }) {
    return NewsAddState(
      title: title ?? this.title,
      content: content ?? this.content,
      images: images ?? this.images,
      hashTag: hashTag ?? this.hashTag,
      status: status ?? this.status,
    );
  }
}
