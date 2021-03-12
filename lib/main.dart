import 'package:flutter/material.dart';
import 'package:wasteagram/screens/entry_screen.dart';
import 'package:wasteagram/screens/home_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

   static final routes = {
    EntryScreen.routeName: (context) => EntryScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    HomeScreen.routeName: (context) => HomeScreen()
  };

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: MyApp.routes,
      // home: HomeScreen(),
    );
  }
}
