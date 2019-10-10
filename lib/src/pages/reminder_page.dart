import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';

class ReminderPage extends StatefulWidget {
  ReminderPage({Key key}) : super(key: key);

  _ReminderPageState createState() => _ReminderPageState();
}

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
CircleAvatar GetIcons(String date){
  if(DateTime.parse(date).weekday==1){
    return CircleAvatar(child: Text('Mon',style: TextStyle(fontSize: 13),)); 
  }
  if(DateTime.parse(date).weekday==2){
    return CircleAvatar(child: Text('Tue',style: TextStyle(fontSize: 13))); 
  }
  if(DateTime.parse(date).weekday==3){
    return  CircleAvatar(child: Text('Wed',style: TextStyle(fontSize: 13))); 
  }
  if(DateTime.parse(date).weekday==4){
    return  CircleAvatar(child: Text('Thu',style: TextStyle(fontSize: 13))); 
  }
  if(DateTime.parse(date).weekday==5){
    return  CircleAvatar(child: Text('Fri',style: TextStyle(fontSize: 13))); 
  }
  if(DateTime.parse(date).weekday==6){
    return  CircleAvatar(child: Text('Sat',style: TextStyle(fontSize: 13))); 
  }
  if(DateTime.parse(date).weekday==7){
    return  CircleAvatar(child: Text('Sun',style: TextStyle(fontSize: 13))); 
  }
  return  CircleAvatar(child: Text('unk',style: TextStyle(fontSize: 13))); 

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

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    final _db=Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: Center(
        child:FutureBuilder(
              future: _db.allReminderEntries,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Reminder> values = snapshot.data;
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                return ListView.builder( 
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  Reminder item=values[index];
                    return Card(
                        child: Dismissible(
                          key: Key(item.id.toString()),
                          background: Container(color: Colors.green,),
                          secondaryBackground: Container(color: Colors.green,),  
                          onDismissed: (direction){
                            if(direction==DismissDirection.endToStart){
                         print('deleted');
                          _db.removeReminderEntry(item);
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Reminder is deleted'),));
                        }else{
                           _db.removeReminderEntry(item);
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text('Reminder is deleted'),));
                        }
                          }, 
                          child: ExpansionTile(
                          leading:GetIcons(item.targetDate.toString()),
                          title: Text(item.title),
                          children: <Widget>[
                            Text(item.description),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Due on :  ${getDay(item.targetDate.toString())} of ${getDate(item.targetDate.toString())}',
                              style: TextStyle(color: Colors.grey),),
                            ),
                            

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