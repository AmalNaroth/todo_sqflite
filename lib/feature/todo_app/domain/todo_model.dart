class TodoModel {
  int? id;
  String title;
  String description;
  TodoModel({
     this.id,
    required this.description,
    required this.title,
  });

  factory TodoModel.generate({
    required String title,
    required String description,
  }) {
    return TodoModel(description: description, title: title);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }

  factory TodoModel.formMap(Map<String, dynamic> data) {
    return TodoModel(
      id: data["id"],
      title: data["title"],
      description: data["description"],
    );
  }
}
