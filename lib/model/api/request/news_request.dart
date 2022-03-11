class NewsRequest {
  final String title;
  final String content;
  final List<String> hashTags;
  final String imageUrl;

  NewsRequest(this.title, this.content, this.hashTags, this.imageUrl);
}
