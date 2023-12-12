import 'package:clinc_reservation_app/screens/user_account_section/user_account_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'cubit/cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel Id', 'channel Name',
            channelDescription: 'channel Description',
            importance: Importance.max));
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("a bg message just showed up : ${message.messageId}");
  }

  static Future<void> init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('boy_doctor');
    final settings = InitializationSettings(android: android);
    //device Info
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.androidId}');

    //
    //firebase
    await Firebase.initializeApp();
    var token = await FirebaseMessaging.instance.getToken();
    UserAccountCubit.deviceToken = token;
    print(token);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    //
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  static void firebaseListenNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showNotification(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body);
      }
    });
  }

  static void onClickedNotification(String? payload) {
    // if (AppCubit.appCubit != null) AppCubit.appCubit.changeIndex(2);
    print("notif clicked");
    AppCubit.currentindex = 2;
    AppCubit.appCubit.changeIndex(2);
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(id, title, body, await _notificationDetails());
  }

  static int inedxforjustdebug = 0;
  static showNotify() {
    switch (inedxforjustdebug) {
      case 1:
        inedxforjustdebug = 2;
        showNotification(
            id: 1,
            title: "تم الحجز",
            body: "تم قبول طلب الحجز يوم الاحد 26 سبتمبر 2021 الساعة 5:00 م",
            payload: "i am payload");
        break;
      case 2:
        inedxforjustdebug = 0;
        showNotification(
            id: 2,
            title: "تعذر قبول طلب الحجز",
            body:
                " تعذر قبول طلب الحجز يوم الاحد 26 سبتمبر 2021 الساعة 5:00 م \n  مع د.وحيد فريد العدوي",
            payload: "i am payload");
        break;
      default:
        inedxforjustdebug = 1;
        showNotification(
            id: 0,
            title: "تم ارسال طلب الحجز",
            body: "تم ارسال طلب الحجز يوم الاحد 26 سبتمبر 2021 الساعة 5:00 م",
            payload: "i am payload");
    }
  }
}
