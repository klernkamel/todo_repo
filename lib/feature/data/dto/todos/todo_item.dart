import 'package:equatable/equatable.dart';
import 'dart:developer' as developer;

class TodoItem extends Equatable {
  final String title;
  final bool done;

  TodoItem({required this.title, this.done = false}) {
    developer.log('Created TodoItem: $title, done: $done');
  }
  
  TodoItem copyWith({
    String? title,
    bool? done,
  }) {
    return TodoItem(
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
  
  @override
  List<Object?> get props => [title, done];
}
