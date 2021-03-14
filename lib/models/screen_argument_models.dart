import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';


class PostDetailArguments {
  // final File image;
  double latitude, longitude;
  int numItems;
  String imageURL;
  Timestamp entryDate;

  PostDetailArguments(this.entryDate, this.imageURL, this.latitude, this.longitude,
      this.numItems);
  // PostDetailArguments(this.image);
}



class NewPostArguments {
  final File image;
  NewPostArguments(this.image);
}
