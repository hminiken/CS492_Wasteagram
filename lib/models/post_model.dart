import 'package:cloud_firestore/cloud_firestore.dart';

class WasteagramPost {
  double latitude, longitude;
  int numItems;
  String imageURL;
  Timestamp entryDate;
  DocumentReference reference;

  WasteagramPost(
      {this.numItems,
      this.entryDate,
      this.imageURL,
      this.latitude,
      this.longitude});

  WasteagramPost.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['num_items'] != null),
        assert(map['image_url'] != null),
        assert(map['latitude'] != null),
        assert(map['longitude'] != null),
        assert(map['entry_date'] != null),
        numItems = map['num_items'],
        imageURL = map['image_url'],
        latitude = map['latitude'],
        longitude = map['longitude'],
        entryDate = map['entry_date'];

  factory WasteagramPost.fromSnapshot(DocumentSnapshot snapshot) {
    return WasteagramPost(
      numItems: snapshot['num_items'],
      imageURL: snapshot['image_url'],
      latitude: snapshot['latitude'],
      longitude: snapshot['longitude'],
      entryDate: snapshot['entry_date'],
    );
  }

}
