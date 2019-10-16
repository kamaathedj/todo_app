


// import 'dart:collection';

import 'package:mobx/mobx.dart';
import 'package:todo_app/src/database/todo_db.dart';

part 'todo_store.g.dart';

class TodoStore=_TodoStore with _$TodoStore;

abstract class _TodoStore with Store{
  Database db=Database();
   
  //  HashMap<int, Todo>_cachedTodo;

  _TodoStore(){

//  _cachedTodo=HashMap<int, Todo>();
  getTodos();
  getReminders();

  }

  
 
 

  @observable
  List<Todo> todos=[];

  @observable
  List<Reminder> reminders=[];

  @action
  Future<void> getTodos()async{
    todos=await db.allTodoEntries();
    // for (final t in await db.allTodoEntries()){
    //   todos.add(singleCache(t));
    // }
    // print(todos);

   
  }

  // Todo singleCache(Todo todo){
  //  if(!_cachedTodo.containsKey(todo.id)){
  //  _cachedTodo[todo.id]=todo;
   
  //  }else{
  //    NullThrownError();
  //  }
  //  return _cachedTodo[todo.id];
  
  // }

  Future<void> getReminders()async{
  reminders=await db.allReminderEntries();
  }
  
}