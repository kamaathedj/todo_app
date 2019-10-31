import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';
import 'package:todo_app/src/notifications/notification.dart';
import 'package:todo_app/src/pages/popup/main_popup.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {  
  String _title;
  String _description;
  final _formKey= GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _createScafoldKey=GlobalKey<ScaffoldState>();

  TimeOfDay selectedTime=TimeOfDay.now();

  DateTime date=DateTime.now();


  

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      key:_createScafoldKey,
      appBar: AppBar(
        title: Text('Todo app'),
        actions: <Widget>[
          Pop()
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:ListView(
            children: <Widget>[
             Container(
             decoration: BoxDecoration(color: Theme.of(context).cardColor,
             borderRadius: BorderRadius.circular(20),
             boxShadow: [
               BoxShadow(color: Theme.of(context).cardColor,
               spreadRadius: 0.1,
               blurRadius: 10)
             ]
             ),
               height: MediaQuery.of(context).size.height/2-100 ,
               width: MediaQuery.of(context).size.width,
            
               child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text('Create  a note or a reminder.',
             style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.w100 ,color:Theme.of(context).textSelectionColor),
             textAlign: TextAlign.center),
               ),
               
               ),
             SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor,
               borderRadius: BorderRadius.circular(20),
               boxShadow: [
                 BoxShadow(color: Colors.black26,
                 spreadRadius: 0.1,
                 blurRadius: 10)
               ]
               ),
                    height: 200,
                    width: 160,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(GroovinMaterialIcons.note_plus,color: Theme.of(context).primaryColor,),
                        iconSize: 40.0,
                        onPressed: ()=>todoDialog(),
                        ),
                        Text('add a note',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100,color: Theme.of(context).textSelectionColor),)

                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor,
               borderRadius: BorderRadius.circular(20),
               boxShadow: [
                 BoxShadow(color: Colors.black26,
                 spreadRadius: 0.1,
                 blurRadius: 10)
               ]
               ),
                    height: 200,
                    width: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(GroovinMaterialIcons.bell_plus,color:Theme.of(context).primaryColor,),
                        iconSize: 40.0,
                        onPressed: (){reminderDialog();},
                        ),
                        Text('add a reminder',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100,),)

                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      )
     
    );
  }
  TextFormField buildTitleFormField(BuildContext context) {
    return TextFormField(
          textCapitalization: TextCapitalization.sentences,
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
              )
            );    
  }
  TextFormField buildDescriptionFormField(BuildContext context) {
    return TextFormField(
          textCapitalization: TextCapitalization.sentences,
          maxLines: 5,
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
              )
            );    
  }
  Future<Widget> todoDialog(){
    final _db=Provider.of<Database>(context);
    final _store=Provider.of<TodoStore>(context);
    return showDialog(
      context: context,
     builder: (context){
       return Form(
      key: _formKey,
      child: Dialog(
      child: Container(
      height: 350,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
          children: <Widget>[
            Text('Add a note',style:  TextStyle(fontSize: 20.0,)),
            Divider(color: Colors.green),
             Text('Title'),
            buildTitleFormField(context),
            SizedBox(height: 10,),
            Text('Description'),
            SizedBox(height: 5,),
            buildDescriptionFormField(context),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    color: Theme.of(context).errorColor,
                    textTheme: ButtonTextTheme.primary,
                    child: Text('Cancel'),
                    onPressed: (){Navigator.pop(context);},
                  ),
                  FlatButton(
                    child: Text('Save',),
                    color: Theme.of(context).buttonColor,
                    textTheme: ButtonTextTheme.primary,
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        _formKey.currentState.save();
                       _db.addTodoEntry(Todo(title: _title,description: _description));
                       _store.getTodos();

                      Navigator.pop(context);
                      }
                    },
                  )
                ],
              )
          ],
        ),
    )
  ],
    ),
  ),
    ),
  );  
}
    );
  }
  
  //reminder dialog
  Future<Widget> reminderDialog(){
    
    final _db=Provider.of<Database>(context);
    final _store=Provider.of<TodoStore>(context); 
    final _notification=Provider.of<NotificationPlugin>(context);
    return showDialog(
      context: context,
     builder: (context){
       return Form(
      key: _formKey,
      child: Dialog(
      child: ListView(
        children: <Widget>[
          Container(
          height: 430,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
              children: <Widget>[
                Text('Add a Reminder',style:  TextStyle(fontSize: 20.0,)),
                Divider(color: Colors.green),
                 Text('Title'),
                buildTitleFormField(context),
                SizedBox(height: 10,),
                Text('Description'),
                SizedBox(height: 5,),
                buildDescriptionFormField(context),
                SizedBox(height: 10,),
                
                // this is the date picker
                // ExpansionTile(
                //   title:Text('Pick a Date'),
                //   children: <Widget>[
                //   Picker(),
                //   ],
                  
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Text('Choose date'),
                  FlatButton(
                    color: Theme.of(context).buttonColor,
                    onPressed: showDate,
                    child: Text('Date'),
                  )
                  ],
                ),
                SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   Text('Choose time '),
                    FlatButton(
                  color: Theme.of(context).buttonColor,
                  onPressed: selectTime,
                  child: Text('Time'),
                )
                 ],
               )
                
                 
                // end
                  
              ],
            ),
    )
  ],
    ),
  ),
  ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          color: Theme.of(context).errorColor,
          textTheme: ButtonTextTheme.primary,
          child: Text('Cancel'),
          onPressed: (){Navigator.pop(context);},
        ),
        FlatButton(
          child: Text('Save',style: TextStyle(color: Colors.white),),
          color: Theme.of(context).buttonColor,
          textTheme: ButtonTextTheme.primary,
          onPressed: (){
            if (_formKey.currentState.validate()){
              _formKey.currentState.save();
             _db.addReminderEntry(Reminder(title: _title,description: _description,targetDate:date ));
             var time=Time(selectedTime.hour,selectedTime.minute);
             _notification.showWeeklyAtDayAndTime(time, Day(DateTime.parse(date.toString()).weekday+1), 1, _title, _description);
             print(DateTime.parse(date.toUtc().toString()).weekday);
             print(selectedTime);
            _store.getReminders();
            Navigator.pop(context);
            
            }
          },
        )
      ],
    )
        ],
      ),
    ),
  );  
}
    );
  }
  Future<void> selectTime()async{
    final time=await showTimePicker(
      context: context, 
      initialTime: selectedTime
    );
    setState(() {
    if(time == null){
       selectedTime=TimeOfDay.now(); 
    }else{
      selectedTime=time;
    }
    });
  }

  DateTime getCombinedTimeAndDate(DateTime theDate,TimeOfDay theTime){
  int hour=theTime.hour;
  int minute=theTime.minute;
  
  
  }
  Future<void> showDate()async{
      final _date=await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 10)),
      lastDate: DateTime.now().add(Duration(days: 10))
    );
    setState(() {
     if(_date==null){
       date=DateTime.now();
     } else{
      date=_date;
     }
     
    });
  }
  String getDate(String date){
  int year=DateTime.parse(date).year;
  int month=DateTime.parse(date).month;
  int day=DateTime.parse(date).day;

  return '$day/$month/$year';
}
  
}

