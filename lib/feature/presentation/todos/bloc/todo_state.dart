import 'package:equatable/equatable.dart';
import 'package:test_app/feature/data/dto/todos/todo_item.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoItem> todos;

  TodoLoaded(this.todos);

  @override
  // TODO: implement props
  List<Object?> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
