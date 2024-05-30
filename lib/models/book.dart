class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category;

  Book({required this.id, required this.title, required this.author, this.description = '', this.category = 'General'});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      author: (json['authors'] != null && json['authors'].isNotEmpty) ? json['authors'][0] : 'No Author',
      description: json['description'] ?? '',
      category: json['categories'] != null && json['categories'].isNotEmpty ? json['categories'][0] : 'General',
    );
  }
}
