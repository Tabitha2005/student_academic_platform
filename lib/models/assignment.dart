class Assignment {
  final String id;
  final String title;
  final String course;
  final DateTime dueDate;
  final String priority;
  final String category;
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


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'course': course,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'category': category,
      'isCompleted': isCompleted,
    };
  }

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      title: json['title'] as String,
      course: json['course'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
