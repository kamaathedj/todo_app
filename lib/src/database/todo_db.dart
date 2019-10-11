import 'dart:async';
import 'package:moor_flutter/moor_flutter.dart';
part 'todo_db.g.dart';


// Define tables that can model a database of recipes.


class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdOn=>dateTime().withDefault(currentDateAndTime)();
}

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdOn=>dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get targetDate=>dateTime().withDefault(currentDateAndTime)();
}

@UseMoor(
  tables: [Todos,Reminders],
)
class Database extends _$Database {
  Database() : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));
    @override
    int get schemaVersion => 2;
  
    @override
    MigrationStrategy get migration{
      return MigrationStrategy(
        beforeOpen: (queryengine,details) async {
          // populate data

          // if(details.wasCreated){
          // await into(todos)
          //     .insert(const TodosCompanion(title: Value('first todo'),description: Value('its nice to have a todo')),);

          // await into(todos)
          //     .insert(const TodosCompanion(title: Value('second todo'),description: Value('wah am doing java')),);
          // await into(todos)
          //     .insert(const TodosCompanion(title: Value('Travelling'),description: Value('get groceries')),);
          // await into(todos)
          //     .insert(const TodosCompanion(title: Value('chores'),description: Value('cut grass')),);

          // }
        },
        onCreate: (Migrator m) {
        return m.createAllTables();
    }
      );
    }

    // watches all todo entries in a given todos. The stream will automatically
  // emit new items whenever the underlying data changes.
    Stream<List<Todo>> watchEntriesInTodo(Todo c) {
    return (select(todos)..where((t) => t.id.equals(c.id))).watch();
  }
  //  returns all the data in todos
    // Future<List<Todo>> get allTodoEntries => select(todos).get();

    Future<List<Reminder>> get allReminderEntries => select(reminders).get();

    Future<List<Todo>> allTodoEntries() {
     return (select(todos)..orderBy([(t) => OrderingTerm(expression: t.createdOn,mode: OrderingMode.desc)])).get();
    }
    //inserts data into todos
    void addTodoEntry(Todo entry) {
         into(todos).insert(entry);
      }
       void addReminderEntry(Reminder entry) {
         into(reminders).insert(entry);
      }

      void removeTodoEntry(Todo item)=>
      (delete(todos)..where((t)=>t.id.equals(item.id))).go();


      void removeReminderEntry(Reminder item)=>
      (delete(reminders)..where((t)=>t.id.equals(item.id))).go();
  
  // updating todo
     Future<int> updateTodos(Todo c){
      return (update(todos)
            ..where((t) => t.id.equals(c.id))
          ).write(TodosCompanion(
            title: Value(c.title),
            description: Value(c.description),
          ),
        );
     }   
    
  }
  
 


