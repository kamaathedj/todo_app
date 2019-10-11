import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';
class Play extends StatefulWidget {
  Play({Key key}) : super(key: key);

  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<Database>(context);
    return Container(
       child: StreamBuilder(
         stream: prov.watchEntriesInTodo(Todo(id: 1)),
       )
    );
  }
}