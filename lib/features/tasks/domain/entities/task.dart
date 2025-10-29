class Task {
  const Task({
    this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  final int? id;
  final String title;
  final String description;
  final bool completed;
}
