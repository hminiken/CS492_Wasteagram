import 'package:flutter/material.dart';
import 'package:wasteagram/models/screen_argument_models.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



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
    var textTheme = Theme.of(context).textTheme;

    final PostDetailArguments args = ModalRoute.of(context).settings.arguments;

    Timestamp postDate = args.entryDate;
    DateTime datetime = postDate.toDate();
    String strDate = DateFormat('EEE, MMM d, ' 'yyyy').format(datetime);

    return Scaffold(
      // key: _scaffoldKey,
      appBar: wasteagramAppBar(context, 'Wasteagram'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(strDate, style: textTheme.headline4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                child: Image.network(args.imageURL,
                    width: MediaQuery.of(context).size.width * 0.95),
                image: true,
                label: 'An image of the waste items',
              )
            ],
          ),
          Text(args.numItems.toString() + " items", style: textTheme.headline4),
          Text("Location: (" +
              args.latitude.toString() +
              ", " +
              args.longitude.toString() +
              ")")
        ],
      ),
    );
  }
}
