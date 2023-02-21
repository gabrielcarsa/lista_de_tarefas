import 'package:flutter/material.dart';

import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> toDo = [];

  final TextEditingController toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: toDoController,
                      decoration: const InputDecoration(
                        labelText: "Tarefa",
                        hintText: "Ir para a academia",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          String text = toDoController.text;
                          setState(() {
                            toDo.add(text);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(15),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for(String i in toDo)
                      ToDoListItem(),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text("Você possui 0 tarefas pendentes"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text("Limpar tudo"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
