import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      theme: ThemeData(primaryColor: Colors.blue),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<_TodoItem> _todos = [];
  final TextEditingController _controller = TextEditingController();
  String text = '123';

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      log('Введите значения тудушки!');
      return;
    }
    setState(() {
      _todos.add(_TodoItem(title: text));
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void _toggleDone(int index) {
    var todo = _todos[index];
    setState(() {
      todo.done = !todo.done;
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mini Todo'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(controller: _controller),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 220,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _addTodo,
                                  child: Text('Добавить'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child:
                    _todos.isEmpty
                        ? const Center(
                          child: Text('Пока нет никаких ToDo-tasks'),
                        )
                        : ListView.builder(
                          itemCount: _todos.length,
                          itemBuilder: (context, index) {
                            final _item = _todos[index];
                            return GestureDetector(
                              onTap: () {
                                _toggleDone(index);
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Checkbox(
                                    value: _item.done,
                                    onChanged: (value) => _toggleDone(index),
                                  ),
                                  title: Text(
                                    _item.title,
                                    style: TextStyle(
                                      decoration:
                                          _item.done
                                              ? TextDecoration.lineThrough
                                              : null,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () => _removeTodo(index),
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoItem {
  final String title;
  bool done;

  _TodoItem({required this.title, this.done = false});
}
