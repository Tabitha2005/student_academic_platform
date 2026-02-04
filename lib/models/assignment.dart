class Assignment {
  final String id;
  final String title;
  final String course;
  final DateTime dueDate;
  final String priority; // High, Medium, Low
  final String category; // Formative or Summative
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.course,
    required this.dueDate,
    required this.priority,
    required this.category,
    this.isCompleted = false,
  });

  // Create a copy with some fields modified
  Assignment copyWith({
    String? id,
    String? title,
    String? course,
    DateTime? dueDate,
    String? priority,
    String? category,
    bool? isCompleted,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      course: course ?? this.course,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
