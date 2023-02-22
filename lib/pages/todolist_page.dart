import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';

import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List<ToDo> toDo = [];
  ToDo? deletedToDo;
  int? deletedToDoPos;
  final TextEditingController toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            String category = "Lazer";
                            setState(() {
                              //instantiating the class
                              ToDo newToDo = ToDo(
                                title: text,
                                date: DateTime.now(),
                                category: category,
                              );

                              //adding to the list
                              toDo.add(newToDo);
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
                      for (ToDo i in toDo)
                        ToDoListItem(
                          todo: i,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text("Você possui ${toDo.length} tarefas pendentes"),
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
      ),
    );
  }

  void onDelete(ToDo todo) {
    deletedToDo = todo;
    deletedToDoPos = toDo.indexOf(todo);

    setState(() {
      toDo.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} removida com sucesso!',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: (){
            setState(() {
              toDo.insert(deletedToDoPos!, deletedToDo!);
            });
          },
        ),
      ),
    );
  }
}
