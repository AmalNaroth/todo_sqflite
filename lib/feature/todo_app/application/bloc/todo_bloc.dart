import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/feature/todo_app/domain/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Future<Database> database;
  final bool databaseExist;
  TodoBloc(this.database, this.databaseExist) : super(TodoInitialState()) {
    on<CreateNewTodoEvent>(
      (event, emit) async {
       // debugPrint("workingg!!!!!!!!!!!!");
        try {
          emit(
            TodoLoadingState(),
          );
          if (!databaseExist) {
            emit(
              TodoErrorState(message: "Database does not exist"),
            );

           // print(event.modelData.description);

            await addData(event.modelData);
            final List<TodoModel> data = await readData();
            emit(
              TodoLoadedState(todoListData: data),
            );
          }
         // debugPrint("Complete!!!!!!");
        } catch (e) {
          emit(
            TodoErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );

    on<InitialTodoEvent>(
      (event, emit) async {
        emit(
          TodoLoadingState(),
        );
        try {
          final List<TodoModel> data = await readData();
          emit(
            TodoLoadedState(todoListData: data),
          );
        } catch (e) {
          emit(
            TodoErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );
  }
  Future<List<TodoModel>> readData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> dbData = await db.query("todos");
    return dbData
        .map(
          (e) => TodoModel.formMap(e),
        )
        .toList();
  }

  Future<void> addData(TodoModel data) async {
    final Database db = await database;
    await db.insert('todos', data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateData(TodoModel data) async {
    final Database db = await database;
    await db.update(
      "todos",
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> deleteData(int id) async {
    final Database db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
