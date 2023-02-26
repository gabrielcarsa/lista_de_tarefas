import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/todo.dart';

class ToDoRepository{

  ToDoRepository(){

    //when you get the return, the value will be assigned to the variable
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  //will only use the variable after it has been assigned
  late SharedPreferences sharedPreferences;
  
  //here is an example of how SharedPreferences works
  /*
  void exampleSharedPreferences(){
    sharedPreferences.setString('name', 'Gabriel Cardoso');
    sharedPreferences.get('name');
  }
  */

  void saveToDoList(List<ToDo> todos){
    final jsonString = json.encode(todos);
  }


}

