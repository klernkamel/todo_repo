import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class TodoCard extends StatelessWidget {
  final bool status;
  final String title;
  final void Function(bool?)? onChageStatus;
  final void Function()? onDeleteTodo;

  const TodoCard({
    super.key,
    required this.status,
    required this.title,
    this.onChageStatus,
    this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    developer.log('Rendering TodoCard: "$title", done: $status');
    return Card(
      child: ListTile(
        leading: Checkbox(value: status, onChanged: onChageStatus),
        title: Text(
          title,
          style: TextStyle(
            decoration: status ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          onPressed: onDeleteTodo,
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
