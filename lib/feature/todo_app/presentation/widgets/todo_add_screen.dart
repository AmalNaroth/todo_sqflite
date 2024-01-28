import 'package:flutter/material.dart';
import 'package:todo_sqflite/feature/todo_app/utils/textController.dart';

class TodoAddScreen extends StatelessWidget {
  TextEditingController title;
  TextEditingController description;
  TodoAddScreen({super.key,
  required this.title,
  required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: title,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Title",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: description,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Description",
            ),
          )
        ],
      ),
    );
  }
}
