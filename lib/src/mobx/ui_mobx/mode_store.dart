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
      fontFamily: 'Oxygen',
      primaryColor: Colors.indigo,
      canvasColor: Colors.white30,
      // cardTheme: CardTheme()
      

    );
  }

  @action
  void darkMode(){
    mode = ThemeData(
      fontFamily: 'Oxygen',
      primarySwatch: Colors.green

    );
  }

}