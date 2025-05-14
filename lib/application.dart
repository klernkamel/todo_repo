import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/presentation/main_screen/main_screen_page.dart';
import 'package:test_app/feature/presentation/photos/bloc/photo.bloc.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_bloc.dart';
import 'package:test_app/feature/presentation/todos/bloc/todo_event.dart';
import 'package:test_app/feature/presentation/todos/todo_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()..add(LoadTodos()),
        ),
        BlocProvider(
          create: (context) => PhotoBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo app',
        theme: ThemeData(primaryColor: Colors.blue),
        home: MainScreenPage(),
      ),
    );
  }
}
