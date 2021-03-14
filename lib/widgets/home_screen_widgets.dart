import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/screen_argument_models.dart';
import 'package:wasteagram/screens/post_detail_screen.dart';

Widget wasteagramAppBar(BuildContext context, String titleText) {
  return AppBar(
    title:  Text(titleText),
    centerTitle: true,
    
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

void pushViewEntry(BuildContext context, Record record) {
  Navigator.of(context).pushNamed(EntryScreen.routeName,
      arguments: PostDetailArguments(record.entryDate, record.imageURL,
          record.latitude, record.longitude, record.numItems));
}

Widget buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("waste_entries").orderBy('entry_date', descending: true).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.docs);
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
  final record = Record.fromSnapshot(data);
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
        border: Border(bottom: BorderSide( color: Colors.grey[300])),
        // borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(strDate, style: textTheme.subtitle1,),
        trailing: Text(record.numItems.toString(), style: textTheme.headline5,),
        onTap: () => pushViewEntry(context, record),
      ),
    ),
  );
}

class Record {
  double latitude, longitude;
  int numItems;
  String imageURL;
  Timestamp entryDate;
  DocumentReference reference;

  Record(
      {this.numItems,
      this.entryDate,
      this.imageURL,
      this.latitude,
      this.longitude});

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['num_items'] != null),
        assert(map['votes'] != null),
        assert(map['votes'] != null),
        assert(map['votes'] != null),
        numItems = map['num_items'],
        imageURL = map['image_url'],
        latitude = map['latitude'],
        longitude = map['longitude'],
        entryDate = map['entry_date'];

  factory Record.fromSnapshot(DocumentSnapshot snapshot) {
    return Record(
      numItems: snapshot['num_items'],
      imageURL: snapshot['image_url'],
      latitude: snapshot['latitude'],
      longitude: snapshot['longitude'],
      entryDate: snapshot['entry_date'],
    );
  }

//  @override
//  String toString() => "Record<$name:$votes>";

}
