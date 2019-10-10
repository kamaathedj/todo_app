import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {  
  String _title;
  String _description;
  final _formKey= GlobalKey<FormState>();
  DateTime _selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo app')
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:ListView(
            children: <Widget>[
             Card( 
                child: Container(
             height: 200,
             width: 350,
             color: Colors.white,
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Text('Create  a reminder or a note.',
               style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.w100 ,),
               textAlign: TextAlign.center),
             ),
             
                ),
                
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    child: Container(
                      height: 200,
                      width: 160,
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.add),
                          iconSize: 50.0,
                          onPressed: ()=>todoDialog(),
                          ),
                          Text('add a Note',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100),)

                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      height: 200,
                      width: 160,
                      color: Colors.amberAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.alarm_add),
                          iconSize: 50.0,
                          onPressed: (){reminderDialog();},
                          ),
                          Text('add a reminder',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100),)

                        ],
                      ),
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
                    color: Colors.redAccent,
                    textTheme: ButtonTextTheme.primary,
                    child: Text('Cancel'),
                    onPressed: (){Navigator.pop(context);},
                  ),
                  FlatButton(
                    child: Text('Save',style: TextStyle(color: Colors.white),),
                    color: Colors.green,
                    textTheme: ButtonTextTheme.primary,
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        _formKey.currentState.save();
                       _db.addTodoEntry(Todo(title: _title,description: _description));
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
    return showDialog(
      context: context,
     builder: (context){
       return Form(
      key: _formKey,
      child: Dialog(
      child: ListView(
        children: <Widget>[
          Container(
          height: 400,
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
                Text('Pick time and Date'),
                // this is the date picker
                 Picker(),
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
          color: Colors.redAccent,
          textTheme: ButtonTextTheme.primary,
          child: Text('Cancel'),
          onPressed: (){Navigator.pop(context);},
        ),
        FlatButton(
          child: Text('Save',style: TextStyle(color: Colors.white),),
          color: Colors.green,
          textTheme: ButtonTextTheme.primary,
          onPressed: (){
            if (_formKey.currentState.validate()){
              _formKey.currentState.save();
             _db.addReminderEntry(Reminder(title: _title,description: _description,targetDate:_dateTime ));
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
  
}
DateTime _dateTime=DateTime.now();
class Picker extends StatefulWidget {  
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  DateTime _selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
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

