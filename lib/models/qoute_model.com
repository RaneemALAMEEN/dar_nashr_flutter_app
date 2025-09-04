class Quote {
  final int id;
  final String text;
  final String bookName;
  final String userName;
  final int numberOfLikes;
  final DateTime createdAt;

  Quote({
    required this.id,
    required this.text,
    required this.bookName,
    required this.userName,
    required this.numberOfLikes,
    required this.createdAt,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      text: json['text'],
      bookName: json['book_name'],
      userName: json['user_name'],
      numberOfLikes: json['number_of_likes'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
