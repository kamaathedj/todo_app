import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/mobx/ui_mobx/mode_store.dart';

class Pop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<LightOrDark>(context);
    return PopupMenuButton(
      itemBuilder: (BuildContext context) { 
        showMenu(
          context: context, 
          items: <PopupMenuEntry>[
           PopupMenuItem(
             enabled: false,
             child: Text('Select light or dark')
             ),
             PopupMenuDivider(height: 5,),
              PopupMenuItem(
                height: 80,
                child:Column(
                 children: <Widget>[
                  //  Text('select colour theme'),
                   Row(
                     children: <Widget>[
                      GestureDetector(
                      onTap: (){
                        prov.normalMode();
                        Navigator.pop(context);
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
                      SizedBox(width: 10,),
                      GestureDetector(
                      onTap: (){
                        prov.darkMode();
                        Navigator.pop(context);
                        },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            shape: BoxShape.circle
                          ),
                          child: Container(
                            
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,),
                          ),
                        ),
                      ),
                      ),
                     ],
                   ),
                  
                 ],
               ),
               
              ),
            //  CheckedPopupMenuItem(
            //    checked: true,
            //    child: Text('Enable dark mode'),
            //    enabled: true,
            //  )
          ],
           position: RelativeRect.fromLTRB(100, 40, 10, 10),
           
        );
      },
      initialValue: 1,
      onSelected: (index){print(index);},
      onCanceled: (){print('closed');},
      tooltip: 'meme',
      elevation: 20.0,
      icon: Icon(Icons.more_vert),
      );
      
  }

  
}

