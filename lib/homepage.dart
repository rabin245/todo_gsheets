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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().init();
    _controller.addListener(() => setState(() {}));
  }

  void _post() async {
    if (_controller.text != '') {
      context.read<TodoProvider>().insert(_controller.text);
    }

    // context.read<TodoProvider>().printCheck();

    setState(() {
      _controller.clear();
    });
  }

  // wait for the data to be fetched from google sheets
  void startLoading() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (context.read<TodoProvider>().checkLoading() == false) {
          setState(() {});
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // start loading until data is fetched
    if (context.read<TodoProvider>().checkLoading() == true) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'POST NOTES',
          style: TextStyle(color: Colors.grey[600]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          context.read<TodoProvider>().checkLoading()
              ? const LoadingIndicator()
              : const MyTodoList(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'enter a note..',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                        });
                      },
                    ),
                  ),
                  controller: _controller,
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
    );
  }
}
