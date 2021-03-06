import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'dart:io' show Platform;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';



class LocalNotificationsManager{
  String currentTimeZone;
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotificationsManager.init(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }
  requestIOSPermission(){

    FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert:true,
      badge: true,
      sound: true
    );
  }
  initializePlatform(){
    _configureLocalTimeZone();

    var initSettingAndroid = AndroidInitializationSettings('lm_app_icon');
    var initSettingIOS = IOSInitializationSettings(

      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceiveNotification notification = ReceiveNotification(
            id: id,
            title: title,
            body: body,
            payload: payload);
        didReceiveLocalNotificationSubject.add(notification);
      }

    );
    initSetting = InitializationSettings(android: initSettingAndroid, iOS: initSettingIOS);

  }
  setOnNotificationReceive(Function onNotificationReceive){
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }
  setOnNotificationClick(Function onNotificationClick) async{
    await flutterLocalNotificationsPlugin.initialize(initSetting, onSelectNotification:(String payload) async {
      onNotificationClick(payload);
    });
  }
  Future<void> showDailyNotification(id, selectedDescription, habitTitle, selectedTime) async {
    tz.initializeTimeZones();
    String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    final location = await tz.getLocation(currentTimeZone);
    final scheduledDate = tz.TZDateTime.from(selectedTime, location);
    print("scheduled date $scheduledDate");

    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      importance:Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter:5000,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "Daily $habitTitle",
      selectedDescription,
      scheduledDate,
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time, uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime

    );
  }
  tz.TZDateTime _nextInstance(selectedTime, locationName){
    DateTime now = tz.TZDateTime.now(tz.local);
    final location = tz.getLocation(locationName);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(selectedTime, location);
    return scheduledDate;
  }

  Future<void> turnOffNotificationById(id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

class ReceiveNotification{
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceiveNotification({@required this.id, @required this.title, @required this.body, @required this.payload });
}
