part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

//initial read todo

class InitialTodoEvent extends TodoEvent {}

//create todo

class CreateNewTodoEvent extends TodoEvent {}

//update todo

class UpdateTodoEvent extends TodoEvent {}

//delate todo

class DeleteTodoEvent extends TodoEvent {}
