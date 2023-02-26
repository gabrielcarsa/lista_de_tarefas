import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/models/todo.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final ToDo todo;
  final Function(ToDo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) => onDelete(todo),
              borderRadius: BorderRadius.circular(10),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(todo.date),
              ),
              Text(
                todo.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
