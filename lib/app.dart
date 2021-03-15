import 'package:flutter/material.dart';
import 'package:wasteagram/screens/post_detail_screen.dart';
import 'package:wasteagram/screens/home_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry/sentry.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class MyApp extends StatefulWidget {
 static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
        await Sentry.captureException(error, stackTrace: stackTrace);
 }

 
  
  static final routes = {
    EntryScreen.routeName: (context) => EntryScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    HomeScreen.routeName: (context) => HomeScreen()
  };

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

static FirebaseAnalytics analytics = FirebaseAnalytics();
 static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: MyApp.routes,
      navigatorObservers: <NavigatorObserver>[observer],
    );
  }
}
