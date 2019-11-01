import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mode_store.g.dart';

class LightOrDark = _LightOrDark with _$LightOrDark;

abstract class _LightOrDark with Store {
  _LightOrDark() {
    getTheme();
  }
  static const String _themeField = 'theme';
  SharedPreferences _prefs;
  static const int theme=0;


  Future<void> getTheme()async{
   _prefs = await SharedPreferences.getInstance();
   int theme = (_prefs.getInt(_themeField) ?? 1);
   if(theme==1){
     normalMode();
   }else if(theme==2){
    redMode();
   }else if(theme==3){
     blueMode();
   }else if(theme==4){
    yellowMode();
  }else if(theme==5){
    indigoMode();
  }else if(theme==6){
    darkMode();
  }else{
    normalMode();
  }
  }

  @observable
  ThemeData mode;

  @action
  void normalMode() {
    mode = ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Color(0xff78AC65),
      fontFamily: 'Oxygen',
      textSelectionColor: Colors.black,
      dialogBackgroundColor: Color(0xffFCFCFC),
      buttonColor: Colors.green,
    );
    _prefs.setInt(_themeField, 1);
  }

  @action
  void redMode() {
    mode = ThemeData(
      primarySwatch: Colors.red,
      // primaryColor: Color(0xff78AC65),
      fontFamily: 'Oxygen',
      textSelectionColor: Colors.black,
      dialogBackgroundColor: Color(0xffFCFCFC),
      buttonColor: Colors.green,
    );
     _prefs.setInt(_themeField, 2);
  }
   @action
  void blueMode() {
    mode = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue,
      fontFamily: 'Oxygen',
      textSelectionColor: Colors.black,
      dialogBackgroundColor: Color(0xffFCFCFC),
      buttonColor: Colors.green,
    );
     _prefs.setInt(_themeField, 3);
  }
   @action
  void yellowMode() {
    mode = ThemeData(
      primarySwatch: Colors.yellow,
      primaryColor: Colors.yellow,
      fontFamily: 'Oxygen',
      textSelectionColor: Colors.black,
      dialogBackgroundColor: Color(0xffFCFCFC),
      buttonColor: Colors.green,
    );
     _prefs.setInt(_themeField, 4);
  }
   @action
  void indigoMode() {
    mode = ThemeData(
      primarySwatch: Colors.indigo,
      primaryColor: Colors.indigo,
      fontFamily: 'Oxygen',
      textSelectionColor: Colors.black,
      dialogBackgroundColor: Color(0xffFCFCFC),
      buttonColor: Colors.green,
    );
     _prefs.setInt(_themeField, 5);
  }

  @action
  void darkMode() {
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
        ));
         _prefs.setInt(_themeField, 6);
  }
}
