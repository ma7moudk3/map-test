import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
class MyNotificationApi {
  static final _notification=FlutterLocalNotificationsPlugin();
  static Future _notificationDetails()async{
    return NotificationDetails(
      iOS: IOSNotificationDetails(),
      android: AndroidNotificationDetails(
        'Chanel Id',
        'Chanel Name',
        'Chanel description',
        importance: Importance.max,
      ),
    );
  }
  static Future ShowNotification({int id=0,String? title,String? body,String? payload})async{
    _notification.show(id, title, body,await _notificationDetails(),payload: payload);
  }
  // static Future init({bool initScheduled=false})async{
  //   final android=AndroidInitializationSettings('@mipmap/ic_luncher');
  //   final iOs=IOSInitializationSettings();
  //   final settings=InitializationSettings(
  //     android: android,
  //     iOS: iOs,
  //   );
  //   await _notification.initialize(settings,onSelectNotification:(payload)async{
  //     onNotifications.add(payload);
  //   }
  //   );
  // }
}