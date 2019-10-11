import 'package:flutter/material.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';
import 'package:todo_app/src/pages/create_page.dart';
import 'package:todo_app/src/pages/notes_page.dart';
import 'package:todo_app/src/pages/reminder_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
         providers: [
           Provider<Database>(
             builder: (_)=>Database(),
           ),
           Provider<TodoStore>(
             builder: (_)=>TodoStore(),
           )
         ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Oxygen'
          
        ),

       
         home: Navigation(),
        
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  Navigation({Key key,}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _counter = 0;
  final List<Widget>_children=[
    CreatePage(),
    NotesPage(),
    ReminderPage(),
  ];
   

  // here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_children[_counter],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _counter,
        onTap: (index){
           setState(() {
             _counter=index;
             
           });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Create')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            title: Text('Notes')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add),
            title: Text('Reminders')
          ),
          
        ],
      ),
      
    );
  }

}