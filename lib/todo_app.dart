import 'package:flutter/material.dart';

class Todo {
  String value;
  bool completed = false;
  bool editing = false;

  Todo({required this.value});
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List _todos = [];

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                // Title
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: const Text(
                    'TODOS',
                    style: TextStyle(
                      fontSize: 100,
                      color: Color.fromRGBO(175, 47, 47, 0.15),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                // Input
                TextField(
                  controller: inputController,
                  decoration: const InputDecoration(
                    hintText: 'What needs to be done?',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      _todos.add(Todo(value: value));
                    });
                    inputController.clear();
                  },
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) => CheckboxListTile(
                      value: _todos[index].completed,
                      onChanged: (value) {
                        setState(() {
                          _todos[index].completed = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: TextField(
                        controller: TextEditingController(
                          text: _todos[index].value,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _todos[index].value = value;
                          });
                        },
                        style: TextStyle(
                          decoration: _todos[index].completed == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      secondary: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _todos.removeAt(index);
                          });
                        },
                      ),
                    ),
                    // separatorBuilder: (context, index) {
                    //   return const Divider();
                    // },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
