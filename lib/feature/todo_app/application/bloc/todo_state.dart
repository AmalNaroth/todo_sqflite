part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitialState extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoLoadedState extends TodoState {
  List<TodoModel> todoListData;
  TodoLoadedState({required this.todoListData});
}

final class TodoErrorState extends TodoState {
  String message;
  TodoErrorState({required this.message});
}
