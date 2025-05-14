import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;

  AddTodo(this.title);

  @override
  // TODO: implement props
  List<Object?> get props => [title];
}

class ToggleDone extends TodoEvent {
  final int index;

  ToggleDone(this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class RemoveTodo extends TodoEvent {
  final int index;

  RemoveTodo(this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}