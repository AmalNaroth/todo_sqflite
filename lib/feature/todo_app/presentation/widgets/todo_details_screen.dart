import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({super.key});

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
          Center(
            child: Text(
              'Title',
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Title',
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Title',
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Title',
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
