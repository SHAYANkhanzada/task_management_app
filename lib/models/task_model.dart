class TaskModel {
  String id;
  String title;
  bool isCompleted;

  TaskModel({required this.id, required this.title, this.isCompleted = false});

  // Convert a Task to a Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  // Convert a Map to a Task
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
