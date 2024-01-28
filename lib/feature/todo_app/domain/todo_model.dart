import 'package:uuid/uuid.dart';

final uuid = const Uuid().v1();

class TodoModel {
  String id;
  String title;
  String description;
  bool status;
  TodoModel({
    required this.id,
    required this.description,
    required this.status,
    required this.title,
  });

  factory TodoModel.generate(
      {required String title,
      required String description,
      required bool status}) {
    return TodoModel(
        id: uuid, description: description, status: status, title: title);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "status": status
    };
  }

  factory TodoModel.formMap(Map<String, dynamic> data) {
    return TodoModel(
        id: data["id"],
        title: data["title"],
        description: data["description"],
        status: data["status"]);
  }
}
