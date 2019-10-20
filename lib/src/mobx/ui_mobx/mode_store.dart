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
      
      
    );
  }

  @action
  void darkMode(){
    mode = ThemeData(
      fontFamily: 'Oxygen',
      primarySwatch: Colors.green,
      primaryColor: Color(0xff442c2e),
      canvasColor: Color(0xfffffbe6),
      cardColor: Color(0xfffedbd0),
      textSelectionColor: Colors.white,
      accentColor: Colors.green,
      buttonColor: Colors.green,
      errorColor: Colors.red,
      

    );
  }

}