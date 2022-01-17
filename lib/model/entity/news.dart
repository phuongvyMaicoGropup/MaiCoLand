


class News {
  const News({
    required this.authorId,
    required this.content,
    required this.title,
    required this.dateCreated,
    required this.dateUpdated,
    required this.images
  });

  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String authorId;
  final String title;
  final String content;
  final String images;
//


}
