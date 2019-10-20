import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';
import 'package:todo_app/src/mobx/ui_mobx/mode_store.dart';
import 'package:todo_app/src/pages/popup/main_popup.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {  
  String _title;
  String _description;
  final _formKey= GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {    
    final modeProvider=Provider.of<LightOrDark>(context);
    return Scaffold(
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
             decoration: BoxDecoration(color: Colors.white,
             borderRadius: BorderRadius.circular(20),
             boxShadow: [
               BoxShadow(color: Colors.white,
               spreadRadius: 0.1,
               blurRadius: 10)
             ]
             ),
               height: MediaQuery.of(context).size.height/2-100 ,
               width: MediaQuery.of(context).size.width,
            
               child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text('Create  a reminder or a note.',
             style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.w100 ,wordSpacing: 3,color: Color(0xff707070)),
             textAlign: TextAlign.center),
               ),
               
               ),
             SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.blue,
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
                        IconButton(icon: Icon(GroovinMaterialIcons.note_plus,color: Colors.white,),
                        iconSize: 40.0,
                        onPressed: ()=>todoDialog(),
                        ),
                        Text('add a Note',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100,color: Colors.white),)

                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.amberAccent,
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
                        IconButton(icon: Icon(GroovinMaterialIcons.reminder,color: Colors.green,),
                        iconSize: 40.0,
                        onPressed: (){reminderDialog();},
                        ),
                        Text('add a reminder',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100,color: Colors.green),)

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
                    child: Text('Save',style: TextStyle(color: Colors.white),),
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
    return showDialog(
      context: context,
     builder: (context){
       return Form(
      key: _formKey,
      child: Dialog(
      child: ListView(
        children: <Widget>[
          Container(
          height: 440,
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
                Text('Pick a Date'),
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
             _db.addReminderEntry(Reminder(title: _title,description: _description,targetDate:_dateTime ));
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
  
}
DateTime _dateTime=DateTime.now();
class Picker extends StatefulWidget {  
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context){
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


