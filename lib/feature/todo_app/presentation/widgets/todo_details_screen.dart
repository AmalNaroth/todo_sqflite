import 'package:flutter/material.dart';
import 'package:todo_sqflite/feature/todo_app/domain/todo_model.dart';

class TodoDetailsScreen extends StatelessWidget {
  final TodoModel data;
  const TodoDetailsScreen({super.key,
  required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              'Todo',
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            data.title,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            data.description,
          ),
         const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
