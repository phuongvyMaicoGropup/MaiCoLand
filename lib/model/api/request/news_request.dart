class NewsRequest {
  final String title;
  final String content;
  final List<String> hashTags;
  final List<String> images;
  final int type;
  final bool isPrivated;

  NewsRequest(this.title, this.content, this.hashTags, this.images, this.type,
      this.isPrivated);
}
