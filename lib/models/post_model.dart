
import 'dart:ffi';

class WasteagramPost {
  Float latitude, longitude, numItems;
  String imageURL;
  DateTime entryDate;

  WasteagramPost({this.numItems, this.entryDate, this.imageURL, this.latitude, this.longitude});

//from documentation
  Map<String, dynamic> toMap() {
    return {
      'num_items' : numItems, 
      'entry_date' : entryDate, 
      'image_url' : imageURL, 
      'latitude' : latitude, 
      'longitude' : longitude, 
    };
  }
 
}