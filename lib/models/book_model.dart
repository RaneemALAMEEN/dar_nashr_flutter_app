class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Book {
  final int id;
  final String title;
  final String description;
  final bool isFree;
  final double price;
  final String coverUrl;
  final String bookFile;
  final String authorName;
  final int? authorId;
  final String? publisherHouseName;
  final int? publisherHouseId; // إذا احتجته
  final String createdAt;
  final List<Category> categories;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.isFree,
    required this.price,
    required this.coverUrl,
    required this.bookFile,
    required this.authorName,
    required this.createdAt,
    this.authorId,
    this.publisherHouseName,
    this.publisherHouseId,
    required this.categories,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isFree: json['is_free'] ?? false,
      price: (json['price'] ?? 0).toDouble(),
      coverUrl: json['cover_url'] ?? '',
      bookFile: json['book_file'] ?? '',
      authorName: json['author_name'] ?? '',
      authorId: json['author_id'],
      publisherHouseName: json['publisher_house_name'],
      publisherHouseId: json['publisher_house_id'],
      createdAt: json['created_at'] ?? '',
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e))
          .toList(),
    );
  }
}
