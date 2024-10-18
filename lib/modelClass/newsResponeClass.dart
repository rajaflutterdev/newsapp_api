// lib/news_model.dart

class Source {
  final String? id; // Nullable
  final String? name; // Nullable

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  @override
  String toString() {
    return 'Source{id: $id, name: $name}';
  }
}

class Article {
  final Source source;
  final String? author; // Nullable
  final String? title; // Nullable
  final String? description; // Nullable
  final String? url; // Nullable
  final String? urlToImage; // Nullable
  final DateTime? publishedAt; // Nullable
  final String? content; // Nullable

  Article({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'] as String?,
    );
  }

  @override
  String toString() {
    return 'Article{title: $title, author: $author, publishedAt: $publishedAt, source: $source}';
  }
}

class NewsResponse {
  final List<Article> articles;

  NewsResponse({required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var articleList = json['articles'] as List<dynamic>? ?? [];
    List<Article> articles = articleList
        .map((article) => Article.fromJson(article as Map<String, dynamic>))
        .toList();

    return NewsResponse(articles: articles);
  }

  @override
  String toString() {
    return 'NewsResponse{articles: $articles}';
  }
}
