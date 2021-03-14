import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wasteagram/models/screen_argument_models.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


class NewPostScreen extends StatefulWidget {
  static const routeName = '/new-post';
  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  LocationData locationData;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
    // loadJournal();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }



    final formKey = GlobalKey<FormState>();

    int entryNumItems = 0;

    uploadWasteagramImage(NewPostArguments args) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference ref =
          storage.ref().child("image1" + DateTime.now().toString());
      StorageUploadTask uploadTask = ref.putFile(args.image);

      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      FirebaseFirestore.instance.collection('waste_entries').add({
        'num_items': entryNumItems,
        'entry_date': DateTime.now(),
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        'image_url': downloadUrl
      });

      Navigator.of(context).pop();
    }

  Widget build(BuildContext context) {

      final NewPostArguments args = ModalRoute.of(context).settings.arguments;
    var textTheme = Theme.of(context).textTheme;


    return Scaffold(
        appBar: wasteagramAppBar(context, 'New Post'),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                
                SizedBox(height: 10),
                Form(
                key: formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.file(args.image,
                      width: MediaQuery.of(context).size.width * 0.85)
                ]),
                    TextFormField(                  
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: textTheme.headline5,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "Number of Wasted Items"),
                  onSaved: (value) {
                    entryNumItems = int.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the number of items';
                    } else {
                      return null;
                    }
                  },
                ),
                  ])
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: SizedBox(
                            width: double.infinity,
                            height: 75,
                            child: Semantics (child: 
                            ElevatedButton.icon(
                              label: Text(""),
                              icon: Icon(Icons.cloud_upload_outlined),
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  uploadWasteagramImage(args);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          button: true,
                          enabled: true,
                          onTapHint: 'Upload selected image',
                )
                )))
              ],
            )));
  }
}
