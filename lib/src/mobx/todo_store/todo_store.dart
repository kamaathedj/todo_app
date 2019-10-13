


// import 'dart:collection';

import 'package:mobx/mobx.dart';
import 'package:todo_app/src/database/todo_db.dart';

part 'todo_store.g.dart';

class TodoStore=_TodoStore with _$TodoStore;

abstract class _TodoStore with Store{
  Database db=Database();

  _TodoStore(){
 
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
  }

  Future<void> getReminders()async{
  reminders=await db.allReminderEntries();
  }
  
}