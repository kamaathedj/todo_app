import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';
//import 'package:todo_app/src/mobx/counter/counter_store.dart';

class NotesPage extends StatelessWidget {

String getTime(String date){
 int hour= DateTime.parse(date).hour;
 int minute= DateTime.parse(date).minute;

 return '$hour : $minute';
}

String getDate(String date){
  int year=DateTime.parse(date).year;
  int month=DateTime.parse(date).month;
  int day=DateTime.parse(date).day;

  return '$day/$month/$year';
}

String getDay(String date){

  if(DateTime.parse(date).weekday==1){
    return 'Monday';
  }
  if(DateTime.parse(date).weekday==2){
    return 'Tuesday';
  }
  if(DateTime.parse(date).weekday==3){
    return 'Wednesday';
  }
  if(DateTime.parse(date).weekday==4){
    return 'Thursday';
  }
  if(DateTime.parse(date).weekday==5){
    return 'Friday';
  }
  if(DateTime.parse(date).weekday==6){
    return 'Saturday';
  }
  if(DateTime.parse(date).weekday==7){
    return 'Sunday';
  }
  return 'a new day';

}
 
  @override
  Widget build(BuildContext context) {
    // final _counter=Provider.of<Counter>(context);
    final _db=Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes 😎'),
      ),
      body: Center(
            child:FutureBuilder(
              future: _db.allTodoEntries,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Todo> values = snapshot.data;
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                return ListView.builder( 
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item=values[index];
                   return Card(
                      child: Dismissible(
                       background: Container(color: Colors.green,),
                      secondaryBackground: Container(color: Colors.green,),   
                      onDismissed: (direction){
                        if(direction==DismissDirection.endToStart){
                         print('deleted');
                          _db.removeTodoEntry(item);
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note is deleted'),));
                        }else{
                          _db.removeTodoEntry(item);
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note is deleted'),));
                        }
                      },
                      key: Key(item.id.toString()),
                            child: ExpansionTile(
                            key: Key(item.id.toString()),
                            leading: CircleAvatar(child: Text(item.id.toString()),),
                            title: Text(item.title),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.description,style: TextStyle(fontSize: 16),),
                              ),

                              SizedBox(height: 10,),
                              Text('Created on : ${getDay(item.createdOn.toString())} on ${getDate(item.createdOn.toString())} at ${getTime(item.createdOn.toString())}',
                              style: TextStyle(color: Colors.grey.shade400),)
                              
                            ],
                          ),
                     ),
                   );
                   },
                  ); 
              }
            ),
      ),
    );
  }
}
