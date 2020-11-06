import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'dart:io' show Platform;

class LocalNotificationsManager{
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
    FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation <IOSFlutterLocalNotificationsPlugin>().requestPermissions(
      alert:true,
      badge: true,
      sound: true
    );
  }
  initializePlatform(){
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
  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      importance:Importance.max,
      priority: Priority.high,
      playSound: true
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
      0, "Test Title", "Test Body", platformChannel, payload: 'New Payload'
    );
  }
}

class ReceiveNotification{
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceiveNotification({@required this.id, @required this.title, @required this.body, @required this.payload });
}
