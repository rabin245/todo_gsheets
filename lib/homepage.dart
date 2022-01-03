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
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().init();
  }

  void _post() async {
    if (_inputController.text != '') {
      context.read<TodoProvider>().insert(_inputController.text);
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
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
                          _inputController.clear();
                        },
                      ),
                    ),
                    controller: _inputController,
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
