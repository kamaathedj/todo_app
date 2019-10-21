import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


part 'mode_store.g.dart';

class LightOrDark=_LightOrDark with _$LightOrDark;
 abstract class _LightOrDark with Store{
   _LightOrDark(){
     normalMode();
   }
 
  @observable
  ThemeData mode;


  @action
  void normalMode(){
    mode = ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Color(0xff78AC65),
      fontFamily: 'Oxygen',
      textSelectionColor: Colors.black,
      dialogBackgroundColor: Color(0xffFCFCFC),
      
      
    );
  }

  @action
  void darkMode(){
    mode = ThemeData(
      fontFamily: 'Oxygen',
      primarySwatch: Colors.green,
      primaryColor: Color(0xff272D25),
      canvasColor: Color(0xff454B42),
      cardColor: Color(0xff171B15),
      textSelectionColor: Colors.white,
      accentColor: Color(0xffF8F8F8),
      buttonColor: Colors.green,
      errorColor: Colors.red,
      scaffoldBackgroundColor: Color(0xff31372F),
      bottomAppBarColor: Color(0xff31372F),
      dialogBackgroundColor: Color(0xff454B42),
     
      // iconTheme: IconThemeData(color: ),
      textTheme: TextTheme(
        title: TextStyle(color: Color(0xffFCFCFC)),
        body1: TextStyle(color: Color(0xffFCFCFC)),
        body2: TextStyle(color: Color(0xffFCFCFC)),
        subhead: TextStyle(color: Color(0xffFCFCFC)),
        subtitle: TextStyle(color: Color(0xffFCFCFC)),
        button: TextStyle(color: Color(0xffFCFCFC)),
        display1: TextStyle(color: Color(0xffFCFCFC)),
        display2: TextStyle(color: Color(0xffFCFCFC)),
        display3: TextStyle(color: Color(0xffFCFCFC)),
        display4: TextStyle(color: Color(0xffFCFCFC)),
        headline: TextStyle(color: Color(0xffFCFCFC)),
        
        
        )
      
      

    );
  }

}