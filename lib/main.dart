import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/src/database/todo_db.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/mobx/todo_store/todo_store.dart';
import 'package:todo_app/src/pages/create_page.dart';
import 'package:todo_app/src/pages/notes_page.dart';
import 'package:todo_app/src/pages/reminder_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
                return MultiProvider(
                  providers: [
                       Provider<Database>(
                         builder: (_)=>Database(),
                       ),
                       Provider<TodoStore>(
                         builder: (_)=>TodoStore(),
                       )
                     ],
                      
                      child: RefreshConfiguration(
                       headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
                       footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
                       headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
                       springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
                       maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
                       maxUnderScrollExtent:0, // Maximum dragging range at the bottom
                       enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
                       enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
                       hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
                       enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
                      child: MaterialApp(
            //             localizationsDelegates: [
            //               // this line is important
            //               RefreshLocalizations.delegate,
            //               // GlobalWidgetsLocalizations.delegate,
            //           GlobalMaterialLocalizations.delegate
            // ],
            // supportedLocales: [
            //   const Locale('en'),
            //   const Locale('zh'),
            // ],
            // localeResolutionCallback:
            //     (Locale locale, Iterable<Locale> supportedLocales) {
            //   //print("change language");
            //   return locale;
            // },
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'Oxygen'
            
          ),

         
           home: Navigation(),
          )
      ),
    );
    
  }
}

class Navigation extends StatefulWidget {
  Navigation({Key key,}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _counter = 0;
  final List<Widget>_children=[
    CreatePage(),
    NotesPage(),
    ReminderPage(),
  ];
   

  // here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_children[_counter],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _counter,
        onTap: (index){
           setState(() {
             _counter=index;
             
           });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Create')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            title: Text('Notes')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add),
            title: Text('Reminders')
          ),
          
        ],
      ),
      
    );
  }

}