import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/data/dto/todos/todo_item.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_event.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<TodoItem> _todos = [];

  TodoBloc() : super (TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodos);
    on<ToggleDone>(_onToggleTodo);
    on<RemoveTodo>(_onRemoveTodo);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    log("Loading todos: ${_todos.length}");
    emit(TodoLoaded(_todos));
  }

  void _onAddTodos(AddTodo event, Emitter<TodoState> emit) {
    final currTodos = (state as TodoLoaded).todos;
    final newTodo = List<TodoItem>.from(currTodos);
    newTodo.add(TodoItem(title: event.title));
    _todos = newTodo;
    log("Todo added: '${event.title}', total todos: ${_todos.length}");
    emit(TodoLoaded(_todos));
  }

  void _onToggleTodo(ToggleDone event, Emitter<TodoState> emit) {
    if (event.index >= 0 && event.index < _todos.length) {
      final newTodos = List<TodoItem>.from(_todos);
      final oldTodo = newTodos[event.index];
      newTodos[event.index] = oldTodo.copyWith(done: !oldTodo.done);
      _todos = newTodos;
      log("Todo toggled at index ${event.index}, done: ${newTodos[event.index].done}");
      emit(TodoLoaded(_todos));
    } else {
      log("Invalid index for toggle: ${event.index}, total todos: ${_todos.length}");
    }
  }

  void _onRemoveTodo(RemoveTodo event, Emitter<TodoState> emit) {
    if (event.index >= 0 && event.index < _todos.length) {
      final newTodos = List<TodoItem>.from(_todos);
      final removed = newTodos.removeAt(event.index);
      _todos = newTodos;
      log("Todo removed at index ${event.index}, title: ${removed.title}, remaining todos: ${_todos.length}");
      emit(TodoLoaded(_todos));
    } else {
      log("Invalid index for removal: ${event.index}, total todos: ${_todos.length}");
    }
  }
}