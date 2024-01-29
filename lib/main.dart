import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/feature/todo_app/application/bloc/todo_bloc.dart';
import 'package:todo_sqflite/feature/todo_app/presentation/todo_list_screen.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'todo_database.db');

  Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
    },
  );

  bool _databaseExist = await databaseExists(
    join(await getDatabasesPath(), "todo_database.db"),
  );

  runApp(
    MyApp(
      database: database,
      databaseExist: _databaseExist,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Database database;
  final bool databaseExist;

  const MyApp({Key? key, required this.database, required this.databaseExist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(database: database),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.purple,
            ),
            useMaterial3: false),
        home: const TodolistScreen(),
      ),
    );
  }
}
