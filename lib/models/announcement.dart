class Announcement {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String audience;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.audience,
  });

  Announcement copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? audience,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      audience: audience ?? this.audience,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'audience': audience,
    };
  }

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      audience: json['audience'] as String,
    );
  }
}
