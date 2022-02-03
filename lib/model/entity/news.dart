


class News {
  const News({
    required this.id,
    required this.authorId,
    required this.content,
    required this.title,
    required this.dateCreated,
    required this.dateUpdated,
    required this.image,
     this.hashTags
  });
  final String id;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String authorId;
  final String title;
  final String content;
  final String image;
  final List<String>? hashTags;
//

  factory News.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for NewsId: $documentId');
    }
    return News(
        id: documentId,
        title: data['title'],
        content: data['content'],
        dateCreated: data['dateCreated'],
        image: data['image'],
        authorId : data['authorId'],
        dateUpdated: data['dateUpdated'],
        hashTags : data['hashTags']
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'dateCreated': dateCreated,
      'authorId': authorId,
      'dateUpdated': dateUpdated,
      'id': id,
      'hashTags': hashTags,
      'image': image,
    };
  }
}
