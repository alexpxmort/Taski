class TaskModel {
  final int id;
  final String title;
  final bool isCompleted;

  TaskModel({required this.id, required this.title, required this.isCompleted});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted ? 1 : 0,
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] == 1,
    );
  }

  /// Método copyWith para criar uma nova instância com alterações específicas
  TaskModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
