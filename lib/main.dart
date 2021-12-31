import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'google_sheets_api.dart';
import 'homepage.dart';
import 'todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetsApi().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ChangeNotifierProvider<TodoProvider>(
        create: (context) => TodoProvider(wsheet: GoogleSheetsApi.worksheet),
        child: const HomePage(),
      ),
      // home: const HomePage(),
    );
  }
}
