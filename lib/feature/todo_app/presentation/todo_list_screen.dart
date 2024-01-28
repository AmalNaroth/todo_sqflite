import 'package:flutter/material.dart';
import 'package:todo_sqflite/feature/todo_app/presentation/widgets/todo_add_screen.dart';
import 'package:todo_sqflite/feature/todo_app/presentation/widgets/todo_details_screen.dart';

class TodolistScreen extends StatelessWidget {
  const TodolistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const TodoDetailsScreen();
                    },
                  );
                },
                title: const Text("Todo name"),
                subtitle: const Text("Todo detatils"),
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: const Text("Edit"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Update Todo"),
                                content: const TodoAddScreen(),
                                actions: [
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Add"),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: const Text("Delate"),
                        onTap: () {},
                      )
                    ];
                  },
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 05,
            );
          },
          itemCount: 10),
      floatingActionButton: SizedBox(
        height: 65,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.purple,
            tooltip: "add",
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Add new todo"),
                    content: const TodoAddScreen(),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Add"),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
