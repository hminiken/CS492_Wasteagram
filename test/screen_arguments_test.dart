import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:wasteagram/models/screen_argument_models.dart';

void main() {
  test(
      'Post Screen Arguments should pass appropriate values to the post screen',
      () {
    final entryDate = Timestamp.fromDate(DateTime.parse('2020-01-01'));
    const numItems = 4;
    const imageURL = 'FAKE URL';
    const latitude = 2.0;
    const longitude = 3.0;

    final postScreenArgs =
        PostDetailArguments(entryDate, imageURL, latitude, longitude, numItems);

    expect(postScreenArgs.entryDate, entryDate);
    expect(postScreenArgs.numItems, numItems);
    expect(postScreenArgs.latitude, latitude);
    expect(postScreenArgs.longitude, longitude);
    expect(postScreenArgs.imageURL, imageURL);
  });

  test(
      'New Post Screen Arguments should pass appropriate values to the post screen',
      () {
    final File image = File('assets/images/blue_flowers.jpg');

    final newPostArgs = NewPostArguments(image);

    expect(newPostArgs.image, image);
  });
}
