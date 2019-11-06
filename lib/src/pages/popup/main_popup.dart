import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:todo_app/src/model/constants.dart';
// import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/mobx/ui_mobx/mode_store.dart';
import 'package:todo_app/src/notifications/notification.dart';

class Pop extends StatefulWidget {
  @override
  _PopState createState() => _PopState();
}

class _PopState extends State<Pop> {
  PersistentBottomSheetController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) { 
        return Constants.choices.map((String choice){
          return PopupMenuItem<String>(
            value: choice,
            child: Row(
              children: <Widget>[
                Constants.settings==choice ? Icon(Icons.settings) : Icon(GroovinMaterialIcons.anvil),
                SizedBox(width: 10,), 
                Text(choice),
              ],
            ),
          );
        }).toList();
      },
      
      onSelected:(String choice){
         if(choice==Constants.settings){
            sheet(context);
          }else if(choice==Constants.about){
            print('about');
          }else{
            print('nothing clicked');
          }

      },
      onCanceled: (){},
      tooltip: 'more',
      elevation: 20.0,
      icon: Icon(Icons.more_vert),
      );
  }

  void sheet(BuildContext context){
    final prov=Provider.of<LightOrDark>(context);
    
    controller= Scaffold.of(context).showBottomSheet(             
        (context)=>BottomSheet(
          elevation: 50,
          enableDrag: true,
          builder: (context)=>Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
              boxShadow: [
              BoxShadow(color: Colors.black26,
              spreadRadius: 0.1,
              blurRadius: 10)
            ]

          ),
        
          height: MediaQuery.of(context).size.height/2,
          
          child: ListView(
            children: <Widget>[
              
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Text('Settings',style: TextStyle(fontSize: 20),)
              ],
            ),
              ListTile(
                title: Text('Colors'),
                subtitle: Text('change to your favourite colour'),
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    GestureDetector(
                    onTap: (){
                      prov.normalMode();
                                               
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.green,),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                    onTap: (){
                      prov.darkMode();
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.black,),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                    onTap: (){
                      prov.redMode();
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.red,),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                    onTap: (){
                      prov.blueMode();
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                    onTap: (){
                      prov.yellowMode();
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow),
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                    onTap: (){
                      prov.indigoMode();
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo),
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.indigo,),
                        ),
                      ),
                    ),
                    ),
                    
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(height: 2,),
                  SizedBox(height: 10,),
                  new SoundSetting()
            ],
          ),
        ), onClosing: () {
          print('clossing bottom sheet');
          },
        )
      );
  }
}

class SoundSetting extends StatefulWidget {
  const SoundSetting({
    Key key,
  }) : super(key: key);

  @override
  _SoundSettingState createState() => _SoundSettingState();
}

class _SoundSettingState extends State<SoundSetting> {
  @override
  Widget build(BuildContext context) {
    final _notification=Provider.of<NotificationPlugin>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text('Play sound on reminder notification',style: TextStyle(fontSize: 15),),
          Switch(
            onChanged: (bool k){
            setState(() {
              _notification.playsound=k;
            });
            },
             value: _notification.playsound,
          )
        ],
      ),
    );
  }
}

