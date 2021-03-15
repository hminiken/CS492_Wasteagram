import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:wasteagram/models/post_model.dart';
import 'package:wasteagram/models/screen_argument_models.dart';
import 'package:wasteagram/screens/post_detail_screen.dart';

Widget wasteagramAppBar(BuildContext context, String titleText) {
  return AppBar(
    // title: Text(titleText),
    title: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('waste_entries').snapshots(),
      builder: (context, snapshot) {
        int wastedItemSum = 0;
        if (snapshot.hasData) {
          for(var i = 0; i < snapshot.data.docs.length; i ++) {
            wastedItemSum += snapshot.data.docs[i]['num_items'];
          }
        return Text('$titleText - $wastedItemSum');

        }
        else {
        return Text(titleText);
      }
      }
      
    ),
    centerTitle: true,
  );
}

void pushViewEntry(BuildContext context, WasteagramPost record) {
  Navigator.of(context).pushNamed(EntryScreen.routeName,
      arguments: PostDetailArguments(record.entryDate, record.imageURL,
          record.latitude, record.longitude, record.numItems));
}

Widget buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("waste_entries")
        .orderBy('entry_date', descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData &&
          snapshot.data.docs != null &&
          snapshot.data.docs.length > 0) {
        return _buildList(context, snapshot.data.docs);
      } else {
        return Scaffold(
        body: Center(child: CircularProgressIndicator()));
      }
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = WasteagramPost.fromSnapshot(data);
  var textTheme = Theme.of(context).textTheme;

  // DateTime entryDate = record.entryDate;
  // String strDate = DateFormat('EEEE, MMMM d, ' 'yyyy').format(entryDate);

  Timestamp postDate = record.entryDate;
  DateTime datetime = postDate.toDate();
  String strDate = DateFormat('EEEE, MMMM d, ' 'yyyy').format(datetime);

  return Padding(
    key: ValueKey(record.entryDate),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Container(
      decoration: BoxDecoration(
        // border: Border.(color: Colors.grey),
        border: Border(bottom: BorderSide(color: Colors.grey[300])),
        // borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(
          strDate,
          style: textTheme.subtitle1,
        ),
        trailing: Text(
          record.numItems.toString(),
          style: textTheme.headline5,
        ),
        onTap: () => pushViewEntry(context, record),
      ),
    ),
  );
}
