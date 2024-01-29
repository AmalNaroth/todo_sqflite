import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/feature/todo_app/application/bloc/todo_bloc.dart';
import 'package:todo_sqflite/feature/todo_app/domain/todo_model.dart';
import 'package:todo_sqflite/feature/todo_app/presentation/widgets/todo_add_screen.dart';
import 'package:todo_sqflite/feature/todo_app/presentation/widgets/todo_details_screen.dart';
import 'package:todo_sqflite/feature/todo_app/utils/textController.dart';

class TodolistScreen extends StatefulWidget {
  const TodolistScreen({
    super.key,
  });

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(
          InitialTodoEvent(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is TodoLoadedState) {
            return _dataList(data: state.todoListData);
          } else {
            return const SizedBox();
          }
        },
      ),
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
                    content: TodoAddScreen(
                      description: TextControllers.addDescriptionController,
                      title: TextControllers.addTitleController,
                    ),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<TodoBloc>().add(
                                  CreateNewTodoEvent(
                                    modelData: TodoModel.generate(
                                      title: TextControllers
                                          .addTitleController.text
                                          .trim(),
                                      description: TextControllers
                                          .addDescriptionController.text
                                          .trim(),
                                    ),
                                  ),
                                );
                          },
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

  Widget _dataList({required List<TodoModel> data}) {
    return ListView.separated(
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
              title: Text(data[index].title),
              subtitle: Text(data[index].description),
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
                              content: TodoAddScreen(
                                title: TextControllers.updateTitleController,
                                description:
                                    TextControllers.updateDescriptionController,
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<TodoBloc>().add(
                                            UpdateTodoEvent(
                                              modelData: TodoModel(
                                                id: data[index].id,
                                                title: TextControllers
                                                    .updateTitleController.text
                                                    .trim(),
                                                description: TextControllers
                                                    .updateDescriptionController
                                                    .text
                                                    .trim(),
                                              ),
                                            ),
                                          );
                                    },
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
                      onTap: () {
                        context.read<TodoBloc>().add(
                              DeleteTodoEvent(id: data[index].id!),
                            );
                      },
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
        itemCount: data.length);
  }
}
