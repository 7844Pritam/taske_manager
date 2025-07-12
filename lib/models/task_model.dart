class Task {
  final int id;
  final String title;
  final bool completed;
  final int userId;
  final String? description;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    this.userId = 1, // Default userId for new tasks
    this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title:
          json['title'] ??
          json['todo'], // Support both JSONPlaceholder ('title') and dummyjson ('todo')
      completed: json['completed'],
      userId: json['userId'] ?? 1, // Default userId if not provided
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'title': title,
      'completed': completed,
      'userId': userId,
    };
    if (description != null) {
      data['description'] = description!;
    }
    return data;
  }
}
