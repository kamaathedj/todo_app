import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';
import 'package:todo_app/src/notifications/notification.dart';

class ReminderPage extends StatefulWidget {
  ReminderPage({Key key}) : super(key: key);

  _ReminderPageState createState() => _ReminderPageState();
}

 String _title;
  String _description;
  final _formKey= GlobalKey<FormState>();

RefreshController _refreshController =
      RefreshController(initialRefresh: false);
PersistentBottomSheetController controller;
 final GlobalKey<ScaffoldState> _reminderScafoldKey=GlobalKey<ScaffoldState>();

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
TextFormField buildTitleFormField(BuildContext context,String hint) {
    return TextFormField(
          textCapitalization: TextCapitalization.sentences,
          initialValue: hint,
          onSaved: (t){
            _title=t;
            print(_title);
          },
          validator:(input){
          if(input.isEmpty){
            return 'please enter a title';
          }
          } ,
          decoration: InputDecoration(
            filled: true,
            // hintText: hint
              )
            );    
  }
  TextFormField buildDescriptionFormField(BuildContext context,String hint) {
    return TextFormField(
          textCapitalization: TextCapitalization.sentences,
          initialValue: hint,
          maxLines: 2,
          onSaved: (t){
            _description=t;
            print(_description);
          },
          validator:(input){
          if(input.isEmpty){
            return 'please enter a description';
          }
          } ,
          decoration: InputDecoration(

            filled: true,
            // hintText: hint
              )
            );    
  }


class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    final _db=Provider.of<Database>(context);
    final _store=Provider.of<TodoStore>(context);
    final _notification=Provider.of<NotificationPlugin>(context);
    return Scaffold(
      key: _reminderScafoldKey,
      appBar: AppBar(
        title: Text('Reminders'),
        actions: <Widget>[
          Center(child: Text('Today',style: TextStyle(fontSize: 18),)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Observer(
              builder: (context)=> CircleAvatar(child: Text(_store.todayTodos().toString()),),
            ),
          )
        ],
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
                  background: Container(color: Colors.green,
                  child: Row(
                  children: <Widget>[
                    Icon(Icons.edit,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text('Edit the reminder',style: TextStyle(color: Colors.white,),)
                  ],
                  ),
                  ),
                  secondaryBackground: Container(color: Colors.red,
                  child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                            Icon(Icons.delete_forever,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text('Delete the reminder',style: TextStyle(color: Colors.white,),)
                           ],
                          ),
                         )
                  ),  
                  confirmDismiss: (direction){
                    if(direction==DismissDirection.endToStart){
                    Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Are you sure you want to delete ?'),
                    action: SnackBarAction(label: 'Delete',
                   onPressed: (){
                     print('deleted');
                     _db.removeReminderEntry(item);
                     _store.reminders.removeAt(index);
                     _store.getReminders();
                     return Future(()=>true);
                     },
                     ),
                     )
                     );
                }else{
                    // _db.removeReminderEntry(item);
                   controller = buildShowBottomSheet(item, _db, _store);
                     return Future(()=>false);
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

  PersistentBottomSheetController buildShowBottomSheet(Reminder item, Database _db, TodoStore _store) {
    return _reminderScafoldKey.currentState.showBottomSheet(
                      (context)=>BottomSheet(
                      elevation: 50,
                      builder: (_) =>
                      Container(
                      height: MediaQuery.of(context).size.height/2+50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(color: Colors.black26,
                        spreadRadius: 0.1,
                        blurRadius: 10)
                      ]
                      
                      ),
                      child: ListView(
                      children: <Widget>[
                       Form(
                     key: _formKey,
                    child: Column(
                    children: <Widget>[
                      Text('Edit Reminder',style: TextStyle(fontSize: 20),),
                      Divider(height: 2,color: Colors.green,),
                      SizedBox(height: 10,),
                      Text('Title'),
                      Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildTitleFormField(context,item.title),
                      ),
                      Text('Description'),
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildDescriptionFormField(context,item.description),
                      ),
                      // Text('select a a new date'),
                      ExpansionTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text('Select a new Date'),
                      children: <Widget>[
                         Picker(),
                      ],
                      ),

                      ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                        color: Theme.of(context).errorColor,
                        textTheme: ButtonTextTheme.primary,
                        child: Text('Cancel'),
                        onPressed: (){
                          controller.close();
                        },
                      ),
                      FlatButton(
                        color: Theme.of(context).buttonColor,
                        textTheme: ButtonTextTheme.primary,
                        child: Text('Save'),
                        onPressed: (){
                          if (_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          _db.updateReminders(Reminder(id: item.id,title: _title,description: _description,targetDate: _dateTime));
                          controller.closed.then((i)=>_store.getReminders());
                          controller.close();
                            }
                        },
                      ),
                      ],
                      )
                    ],
                  ),
                ),
               
              ],
          )
                      
                      ),
                     onClosing: (){},
                    )
                  );
  }
  
}

DateTime _dateTime=DateTime.now();
class Picker extends StatefulWidget {  
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context){
    return Container(
      width: 300,
       child:  MonthPicker(
                  firstDate: DateTime.now().subtract(const Duration(days: 20)),
                   onChanged: (DateTime value) {
                     setState(() {
                       _dateTime=value;
                       print(_dateTime);
                     });
                   }, 
                   lastDate: DateTime.now().add(const Duration(days: 30)), 
                   selectedDate: _dateTime

                ),
    );
  }
}


