import 'package:flutter/material.dart';
import 'package:test_app/feature/presentation/todos/todo_page.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          SizedBox(
            width: 220,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => TodoPage()));
              },
              child: Text('Todo Page'),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 220,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Rest api page'),
            ),
          ),
        ],
      ),
    );
  }
}
