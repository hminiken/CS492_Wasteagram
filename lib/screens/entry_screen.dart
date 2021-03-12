import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';

class EntryScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  @override
  EntryScreenState createState() => EntryScreenState();
}

class EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();
    // loadJournal();
  }

  Widget build(BuildContext context) {
    var TextTheme = Theme.of(context).textTheme;




    return Scaffold(
      // key: _scaffoldKey,
      appBar: wasteagramAppBar(context, 'Wasteagram'),
      // body: bodyWidget,
      // endDrawer: darkModeDrawer(context),
      body:
       Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("The Data Goes Here", style: TextTheme.headline4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/blue_flowers.jpg',
                  width: MediaQuery.of(context).size.width * 0.85),
            ],
          ),
          Text("5", style: TextTheme.headline4),
          Text('48.123455, 135.234565')
        ],
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
    );
  }
}
