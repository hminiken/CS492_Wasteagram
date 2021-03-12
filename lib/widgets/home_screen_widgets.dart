import 'package:flutter/material.dart';

Widget wasteagramAppBar(BuildContext context, String titleText) {
  return AppBar(
      title: Center(
        child: Text(titleText),
      ),
      // actions: <Widget>[
      //   new IconButton(
      //       icon: Icon(Icons.settings),
      //       onPressed: () {
      //         //  updateAppTheme();
      //         // _scaffoldKey.currentState.openEndDrawer();
      //       })
      // ]
      );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: SafeArea(
          child: Text('Hi'),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            onTap: () => print('tap on close'),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.close,
                    color: Theme.of(context).accentColor,
                  ),
                  Text('close'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}