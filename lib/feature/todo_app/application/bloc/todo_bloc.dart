import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/feature/todo_app/domain/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Database database;

  TodoBloc({required this.database}) : super(TodoInitialState()) {
    on<CreateNewTodoEvent>(_onCreateNewTodoEvent);
    on<InitialTodoEvent>(_onInitialTodoEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }

  Future<void> _onCreateNewTodoEvent(
      CreateNewTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoadingState());
      await _addData(event.modelData);
      final List<TodoModel> data = await _readData();
      emit(TodoLoadedState(todoListData: data));
    } catch (e) {
      emit(TodoErrorState(message: e.toString()));
    }
  }

  Future<void> _onInitialTodoEvent(
      InitialTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      final List<TodoModel> data = await _readData();
      emit(TodoLoadedState(todoListData: data));
    } catch (e) {
      emit(TodoErrorState(message: e.toString()));
    }
  }

  Future<void> _onUpdateTodoEvent(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoadingState());
      await _updateData(event.modelData);
      emit(TodoLoadedState(todoListData: await _readData()));
    } catch (e) {
      emit(TodoErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteTodoEvent(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoadingState());
      await _deleteData(event.id);
      emit(TodoLoadedState(todoListData: await _readData()));
    } catch (e) {
      emit(TodoErrorState(message: e.toString()));
    }
  }

  Future<List<TodoModel>> _readData() async {
    final List<Map<String, Object?>> value =
        await database.rawQuery('SELECT * FROM Todos');
    return value.map((e) => TodoModel.formMap(e)).toList();
  }

  Future<void> _addData(TodoModel data) async {
    await database.rawInsert(
        'INSERT INTO Todos(title, description) VALUES(?, ?)',
        [data.title, data.description]);
  }

  Future<void> _updateData(TodoModel data) async {
   // print(data.id);
    await database.rawUpdate(
      'UPDATE Todos SET title = ?, description = ? WHERE id = ?',
      [data.title, data.description, data.id],
    );
  }

  Future<void> _deleteData(int id) async {
    await database.rawDelete('DELETE FROM Todos WHERE id = ?', [id]);
  }
}
