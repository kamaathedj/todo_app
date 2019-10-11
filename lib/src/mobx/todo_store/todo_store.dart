


import 'package:mobx/mobx.dart';
import 'package:todo_app/src/database/todo_db.dart';

part 'todo_store.g.dart';

class TodoStore=_TodoStore with _$TodoStore;

abstract class _TodoStore with Store{
  Database db=Database();

  _TodoStore(){
  getTodos();
  }

  @observable
  List<Todo> todos=[];

  @action
  Future<void> getTodos()async{
    todos=await db.allTodoEntries;
  }
  
}