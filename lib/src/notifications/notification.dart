import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
class NotificationPlugin{
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool playsound=false;
  Color color=Colors.red;

  NotificationPlugin(){
    _initializePlugin();
  }

  _initializePlugin(){
   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   final initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
   final initializationSettingsIOS = IOSInitializationSettings();
   final initializationSettings = InitializationSettings(
     initializationSettingsAndroid,
     initializationSettingsIOS
   );  
   _flutterLocalNotificationsPlugin.initialize(
     initializationSettings,
     onSelectNotification: onSelectNotification,
     );
  }

  Future onSelectNotification(String payload) async{
    if(payload !=null){
      print('notification payload : '+payload);
    }

  }

  Future<void> ScheduledNotification( int id, String title, String description, DateTime scheduledDate)async{
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'show weekly channel id',
    'show weekly channel name',
    'show weekly description',
    enableLights: true,
    playSound: playsound,
    style: AndroidNotificationStyle.BigText,
    color: color
  );
  final iOSPlatformChannelSpecifics=IOSNotificationDetails();

  final platformChannelSpecifics=NotificationDetails(
    androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics
  );
  await _flutterLocalNotificationsPlugin.schedule(id, title, description, scheduledDate, platformChannelSpecifics);
  

  }
  // getting all the pending notifications
  Future<List<PendingNotificationRequest>> getScheduledNotifications() async{
    final pendingNotifications = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  // cancelling a single notification
  Future cancelNotification(int id) async{
  await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // cancel all notifications
  Future cancelAllNotification() async{
    await _flutterLocalNotificationsPlugin.cancelAll();
    
  }

  // scheduling a notification
  Future<void> scheduleNotify() async{
    final iOSPlatformChannelSpecifics=IOSNotificationDetails();
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'show weekly channel id',
    'show weekly channel name',
    'show weekly description'
  );
    final platformChannelSpecifics=NotificationDetails(
    androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics
  );
    await _flutterLocalNotificationsPlugin.schedule(1, 
    'first noticy', 
    'remember me', 
    DateTime.now().add(Duration(hours: 2)), 
    platformChannelSpecifics);
  } 

}