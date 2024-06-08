class Book {
  final String title;
  final String authorName;
  final String coverId;

  Book({
    required this.title,
    required this.authorName,
    required this.coverId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Nenhum título',
      authorName:
          (json['author_name'] != null && json['author_name'].isNotEmpty)
              ? json['author_name'][0]
              : 'Autor desconhecido',
      coverId: json['cover_i']?.toString() ?? '',
    );
  }

  String get coverUrl => 'https://covers.openlibrary.org/b/id/$coverId-L.jpg';
}
