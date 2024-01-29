part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

//initial read todo

class InitialTodoEvent extends TodoEvent {}

//create todo

class CreateNewTodoEvent extends TodoEvent {
  TodoModel modelData;
  CreateNewTodoEvent({required this.modelData});
}

//update todo

class UpdateTodoEvent extends TodoEvent {
  TodoModel modelData;
  UpdateTodoEvent({required this.modelData});
}

//delate todo

class DeleteTodoEvent extends TodoEvent {
  int id;
  DeleteTodoEvent({required this.id});
}
