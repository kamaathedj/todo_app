import 'package:flutter/material.dart';

class EditSheet extends StatefulWidget {

 final GlobalKey<ScaffoldState> _state;
  EditSheet(this._state);

  @override
  _EditSheetState createState() => _EditSheetState();
}

class _EditSheetState extends State<EditSheet> {
  PersistentBottomSheetController controller;

  String _title;

  String _description;

  final _formKey= GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    controller=this.widget._state.currentState.showBottomSheet(
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
            // child: buildTitleFormField(context,item.title),
            ),
            Text('Description'),
            Padding(
            padding: const EdgeInsets.all(8.0),
            // child: buildDescriptionFormField(context,item.description),
            ),
            // Text('select a a new date'),
            // ExpansionTile(
            // leading: Icon(Icons.calendar_today),
            // title: Text('Select a new Date'),
            // children: <Widget>[
            //    Picker(),
            // ],
            // ),
            // FlatButton(
              // child: Text(date.toString()),
              // color: Theme.of(context).buttonColor,
              // onPressed: showDate,
            // ),

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
                // _db.updateReminders(Reminder(id: item.id,title: _title,description: _description,targetDate: _dateTime));
                // controller.closed.then((i)=>_store.getReminders());
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