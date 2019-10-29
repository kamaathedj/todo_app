import 'package:flutter/material.dart';
import 'package:todo_app/src/model/constants.dart';
// import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/mobx/ui_mobx/mode_store.dart';

class Pop extends StatelessWidget {
  PersistentBottomSheetController controller;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) { 
        return Constants.choices.map((String choice){
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
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
                      controller.close();                              
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
                      controller.close();
                      
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
                        controller.close();
                        
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
                      controller.close();
                      
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
                      controller.close();
                      
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
                      controller.close();
                  
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
                  Divider(height: 2,)
            ],
          ),
        ), onClosing: () {
          print('clossing bottom sheet');
          },
        )
      );
  }

  
}

