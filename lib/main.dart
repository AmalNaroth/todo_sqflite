import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/feature/todo_app/application/bloc/todo_bloc.dart';
import 'package:todo_sqflite/feature/todo_app/presentation/todo_list_screen.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), "todo_database.db"),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status INTEGER)");
    },
    version: 1,
  );

  bool _databaseExist = await databaseExists(
    join(await getDatabasesPath(), "todo_database.db"),
  );
  runApp(MyApp(
    database: database,
    databaseExist: _databaseExist,
  ));
}

class MyApp extends StatelessWidget {
  final Future<Database> database;
  final bool databaseExist;

  const MyApp({Key? key, required this.database, required this.databaseExist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(database, databaseExist),
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
          useMaterial3:
              false, // Commented out because useMaterial3 is not available in all Flutter versions
        ),
        home: TodolistScreen(database: database,
        databaseExist: databaseExist),
      ),
    );
  }
}
