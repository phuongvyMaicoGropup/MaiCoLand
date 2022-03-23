class NewsRequest {
  final String title;
  final String content;
  final List<String> hashTags;
  final String imageUrl;
  final int type; 

  NewsRequest(this.title, this.content, this.hashTags, this.imageUrl, this.type);
}
