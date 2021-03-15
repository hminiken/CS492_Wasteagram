import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:wasteagram/models/post_model.dart';

void main() {
  test('Post created from Map should have appropritae property values', () {
      final entryDate = Timestamp.fromDate(DateTime.parse('2020-01-01'));
      const numItems = 4;
      const imageURL = 'FAKE URL';
      const latitude = 2.0;
      const longitude = 3.0;

      final foodWastePost = WasteagramPost.fromMap({
        'num_items' : numItems,
        'image_url' : imageURL,
        'latitude' : latitude,
        'longitude' : longitude,
        'entry_date' : entryDate
      });

      expect(foodWastePost.entryDate, entryDate);
      expect(foodWastePost.numItems, numItems);
      expect(foodWastePost.latitude, latitude);
      expect(foodWastePost.longitude, longitude);
      expect(foodWastePost.imageURL, imageURL);
  });

 
}