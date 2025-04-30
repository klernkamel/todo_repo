import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoCard extends StatefulWidget {
  final bool status;
  final String title;
  void Function(bool?)? onChageStatus;
  void Function()? onDeleteTodo;

  TodoCard({
    super.key,
    required this.status,
    required this.title,
    this.onChageStatus,
    this.onDeleteTodo,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(value: widget.status, onChanged: widget.onChageStatus),
        title: Text(
          widget.title,
          style: TextStyle(
            decoration: widget.status ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          onPressed: widget.onDeleteTodo,
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
