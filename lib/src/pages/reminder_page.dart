import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';

class ReminderPage extends StatefulWidget {
  ReminderPage({Key key}) : super(key: key);

  _ReminderPageState createState() => _ReminderPageState();
}

RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
CircleAvatar getIcons(String date,DateTime dateTime){
  if(DateTime.parse(date).weekday==1){
    return CircleAvatar(child: Text('Mon',style: TextStyle(fontSize: 13,color: Colors.white),),backgroundColor: comparingDates(dateTime),); 
  }
  if(DateTime.parse(date).weekday==2){
    return CircleAvatar(child: Text('Tue',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 
  }
  if(DateTime.parse(date).weekday==3){
    return  CircleAvatar(child: Text('Wed',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 
  }
  if(DateTime.parse(date).weekday==4){
    return  CircleAvatar(child: Text('Thu',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 
  }
  if(DateTime.parse(date).weekday==5){
    return  CircleAvatar(child: Text('Fri',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 
  }
  if(DateTime.parse(date).weekday==6){
    return  CircleAvatar(child: Text('Sat',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 
  }
  if(DateTime.parse(date).weekday==7){
    return  CircleAvatar(child: Text('Sun',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 
  }
  return  CircleAvatar(child: Text('unk',style: TextStyle(fontSize: 13,color: Colors.white)),backgroundColor: comparingDates(dateTime),); 

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
Color comparingDates(DateTime date){
if(DateTime.now().day==date.day){
  return Colors.red;
}else if(DateTime.now().isAfter(date)){
  return Colors.grey;
}else{
 return Colors.green;
}

}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    final _db=Provider.of<Database>(context);
    final _store=Provider.of<TodoStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: Observer(
        builder: (context){
          return SmartRefresher(
             controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("pull up load");
              }
              else if(mode==LoadStatus.loading){
                body =    CircularProgressIndicator();
                
              }
              else if(mode == LoadStatus.failed){
                body = Text("Load Failed!Click retry!");
              }
              else if(mode == LoadStatus.canLoading){
                  body = Text("release to load more");
                  
              }
              else{
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          
          onRefresh: (){
             Future.delayed(Duration(milliseconds: 1000));
             _store.getReminders();
            _refreshController.refreshCompleted();
          },
          onLoading:(){
              Future.delayed(Duration(milliseconds: 1000));
          if(mounted) 
          _store.getReminders();
          _refreshController.loadComplete();

          },

      child: ListView.builder( 
      itemCount: _store.reminders.length,
      itemBuilder: (BuildContext context, int index) {
        Reminder item=_store.reminders[index];
            return Card(
                child: Dismissible(
                  key: Key(item.id.toString()),
                  background: Container(color: Colors.green,),
                  secondaryBackground: Container(color: Colors.green,),  
                  onDismissed: (direction){
                    if(direction==DismissDirection.endToStart){
                 
                  _db.removeReminderEntry(item);
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Reminder is deleted'),));
                }else{
                    _db.removeReminderEntry(item);
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Reminder is deleted'),));
                }
                  }, 
                  child: ExpansionTile(
                  leading:getIcons(item.targetDate.toString(),item.targetDate),
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
        ),
          );
        },
             
      ),
    );
  }
}