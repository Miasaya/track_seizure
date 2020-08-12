import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotificationsWidget extends StatefulWidget {
  LocalNotificationsWidget({Key key}) : super(key: key);

  @override
  _LocalNotificationsWidgetState createState() => _LocalNotificationsWidgetState();
}

class _LocalNotificationsWidgetState extends State<LocalNotificationsWidget> {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
 @override
  void initState() async { 
    super.initState();
    final initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id,title,body,payload)=> (selectNotification(payload));

    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}