class Book {
  final int? id;
  final String title;
  final String author;

  Book({this.id, required this.title, required this.author});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
    };
  }
}
