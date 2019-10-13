import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';
//import 'package:todo_app/src/mobx/counter/counter_store.dart';

class NotesPage extends StatefulWidget {

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

   RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final GlobalKey<ScaffoldState> _scafoldKey=GlobalKey<ScaffoldState>();



  String _title;
  String _description;
  final _formKey= GlobalKey<FormState>();
  PersistentBottomSheetController controller;

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
    final _store=Provider.of<TodoStore>(context);
    final _db=Provider.of<Database>(context);
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Notes 😎'),
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
             _store.getTodos();
            _refreshController.refreshCompleted();
          },
          onLoading:(){
              Future.delayed(Duration(milliseconds: 1000));
          if(mounted) 
          _store.getTodos();
          _refreshController.loadComplete();

          },
          
    child:  ListView.builder( 
    itemCount: _store.todos.length,
  itemBuilder: (BuildContext context, int index) {
  Todo item=_store.todos[index];
    return Card(
      child: Dismissible(
      confirmDismiss:(direction){
        if(direction==DismissDirection.endToStart){
          return Future(()=>true);
        }else{

      controller=Scaffold.of(context).showBottomSheet(
      (context)=>BottomSheet(
        elevation: 5,
        builder: (_)=>Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black26,
              spreadRadius: 0.1,
              blurRadius: 10)
            ]
            
            ),
            child:ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                      child: Column(
                      children: <Widget>[
                        Text('Edit Note',style: TextStyle(fontSize: 20),),
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
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                            color: Colors.red,
                            textTheme: ButtonTextTheme.primary,
                            child: Text('Cancel'),
                            onPressed: (){
                              controller.close();
                            },
                          ),
                          FlatButton(
                            color: Colors.green,
                            textTheme: ButtonTextTheme.primary,
                            child: Text('Save'),
                            onPressed: (){
                              if (_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              _db.updateTodos(Todo(id: item.id,title: _title,description: _description));
                              controller.closed.then((i)=>_store.getTodos());
                              controller.close();
                                }
                            },
                          ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
            )
        ), onClosing: () {},
              

            )
          );
          return Future(()=>false);
        }
      },
        background: Container(color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.edit,color: Colors.white,),
              SizedBox(width: 10,),
              Text('Edit the note',style: TextStyle(color: Colors.white,),)
            ],
          ),
        )
        ),
      secondaryBackground: Container(color: Colors.red,
          child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.delete_forever,color: Colors.white,),
              SizedBox(width: 10,),
              Text('Delete the note',style: TextStyle(color: Colors.white,),)
            ],
          ),
        )
      
      ),   
      onDismissed: (direction){
        if(direction==DismissDirection.endToStart){
          print('deleted');
          _db.removeTodoEntry(item);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note is deleted'),));
        }else{
          // _db.removeTodoEntry(item);
          //  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note is deleted'),));
        
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
  ) 
                  
                
        );
        },
      )
    );
  }
}
