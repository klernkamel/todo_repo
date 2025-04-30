import 'package:flutter/material.dart';
import 'package:test_app/feature/presentation/main_screen/main_screen_page.dart';


class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      theme: ThemeData(primaryColor: Colors.blue),
      home: MainScreenPage(),
    );
  }
}
