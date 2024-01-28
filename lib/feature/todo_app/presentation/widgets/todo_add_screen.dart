import 'package:flutter/material.dart';

class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(),
              hintText: "Title",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
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
