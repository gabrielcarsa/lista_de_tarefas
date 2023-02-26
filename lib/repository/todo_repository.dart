import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/todo.dart';

const String toDoListKey = 'todo_list';

class ToDoRepository {

  //will only use the variable after it has been assigned
  late SharedPreferences sharedPreferences;

  //function to get the to-do list from the sharedPreferences
  Future<List<ToDo>> getToDoList() async{
    sharedPreferences = await SharedPreferences.getInstance();

    //if the sharedPrefences return is null, i put an empty json by default
    final String jsonString = sharedPreferences.getString(toDoListKey) ?? '[]';

    final List jsonDecoded = jsonDecode(jsonString) as List;

    //for each element of the list is transformed into a to-do object
    return jsonDecoded.map((e) => ToDo.fromJson(e)).toList();
  }

  //function that will save to-do list in sharedPreference as JSON
  void saveToDoList(List<ToDo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(toDoListKey, jsonString);
  }

  //here is an example of how SharedPreferences works
  /*
  void exampleSharedPreferences(){
    sharedPreferences.setString('name', 'Gabriel Cardoso');
    sharedPreferences.get('name');
  }
  */

}
