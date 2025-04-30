import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateTodoDioalog extends StatelessWidget {
  CreateTodoDioalog({super.key, required this.controller, this.onAddTodo});
  final TextEditingController controller;
  void Function()? onAddTodo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [Expanded(child: TextField(controller: controller))],
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: onAddTodo,
                  child: Text('Добавить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
