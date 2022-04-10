import 'package:flutter/material.dart';
import 'package:todo_gsheets/list_of_todo.dart';
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
      Navigator.of(context).pop();
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TODOS',
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (BuildContext context, todoProvider, child) => Column(
          children: [
            todoProvider.checkLoading
                ? const LoadingIndicator()
                : const MyTodoList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPopUp(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void showAddPopUp(context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(16),
            title: const Text('Add todo'),
            children: [
              TextField(
                autofocus: true,
                controller: _inputController,
                decoration: InputDecoration(
                  hintText: 'Enter a todo..',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _inputController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _post,
                    child: const Text(
                      'Add',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _inputController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
