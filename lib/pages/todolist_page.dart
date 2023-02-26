import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/repository/todo_repository.dart';

import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<ToDo> toDo = [];
  ToDo? deletedToDo;
  int? deletedToDoPos;
  final TextEditingController toDoController = TextEditingController();
  final ToDoRepository toDoRepository = ToDoRepository();



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

                            toDoRepository.saveToDoList(toDo);
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
                      onPressed: showDeleteConfirmationDialog,
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

  //will show a confirmation window for deletion
  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja apagar tudo?'),
        content: const Text('Você realmente deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAll();
            },
            child: const Text(
              'Limpar tudo',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*-----
  FUNCTIONS
  -----*/

  //delete all tasks
  void deleteAll(){
    setState(() {
      toDo.clear();
    });
  }

  //delete a task with snackBar
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
          onPressed: () {
            setState(() {
              toDo.insert(deletedToDoPos!, deletedToDo!);
            });
          },
        ),
      ),
    );
  }
}
