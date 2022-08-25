import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:android_assignment/screens/profile.dart';
import 'package:android_assignment/screens/posts.dart';
import 'package:android_assignment/utilities/bottomnavigation.dart';
import 'package:android_assignment/screens/login.dart';
import 'package:android_assignment/screens/register.dart';
import 'package:android_assignment/screens/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: Color.fromARGB(255, 20, 96, 209),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            importance: NotificationImportance.High,
            enableVibration: true)
      ]);
  runApp(MyApp());
}

void notify() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title: 'PhotoHub',
      body: 'You have been logged out!!',
      //notificationLayout: NotificationLayout.BigPicture,
      // bigPicture:
      //     'https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg?auto=webp&quality=85,70'
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(backgroundColor: Colors.amberAccent),
      title: "Individual Assignment",
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/view': (context) => ViewData(),
        '/homepage': (context) => BottomNav(),
        '/allposts': (context) => Posts(),
        '/myprofile': (context) => ViewProfile()
      },
    );
  }
}
