import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_gsheets/list_of_todo.dart';
import 'button.dart';
import 'loading_indicator.dart';
import 'todo_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().init();
  }

  void _post() async {
    context.read<TodoProvider>().insert();
  }

  // wait for the data to be fetched from google sheets
  void startLoading() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (context.read<TodoProvider>().checkLoading == false) {
          setState(() {});
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // start loading until data is fetched
    if (context.read<TodoProvider>().checkLoading == true) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              //  edit
              await context.read<TodoProvider>().editTodo(6, 'edit test');
            },
            icon: Icon(Icons.edit),
          ),
        ],
        centerTitle: true,
        title: Text(
          'TODOS',
          style: TextStyle(color: Colors.grey[600]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<TodoProvider>(
        builder: (BuildContext context, todoProvider, child) => Column(
          children: [
            todoProvider.checkLoading
                ? const LoadingIndicator()
                : const MyTodoList(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'enter a todo..',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          todoProvider.clearInputController();
                        },
                      ),
                    ),
                    controller: todoProvider.inputController,
                  ),
                ),
                MyButton(
                  text: 'P O S T',
                  function: _post,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
