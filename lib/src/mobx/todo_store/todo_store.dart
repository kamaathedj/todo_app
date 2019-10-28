import 'package:mobx/mobx.dart';
import 'package:todo_app/src/database/todo_db.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  Database db = Database();

  //  HashMap<int, Todo>_cachedTodo;

  _TodoStore() {
//  _cachedTodo=HashMap<int, Todo>();
    getTodos();
    getReminders();
  }
  
  @observable
  List<Todo> todos = [];
  // ObservableList<Todo> todos=ObservableList<Todo>();


  @observable
  List<Reminder> reminders = [];

  @computed
  int get numberOfReminders => reminders.length;

  @computed
  int get numberOfTodos => todos.length;

  int todayTodos() {
    int k = 0;
    for (final r in reminders) {
      if (r.targetDate.day == DateTime.now().day) {
        k++;
      }
    }
    return k;
  }

  @action
  Future<void> getTodos() async {
    todos = await db.allTodoEntries();
  }

  Future<void> getReminders() async {
    reminders = await db.allReminderEntries();
    todayTodos();
  }
}
