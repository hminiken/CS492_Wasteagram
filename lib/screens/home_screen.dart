import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/screen_argument_models.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        // loadEntries();
      });
    });
  }

  void pushNewEntry(BuildContext context) {
    Navigator.of(context)
        .pushNamed(NewPostScreen.routeName, arguments: NewPostArguments(image));
  }

  File image;
  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile = ) {
      
    }
    image = File(pickedFile.path);

    setState(() {
      pushNewEntry(context);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        appBar: wasteagramAppBar(context, 'Wasteagram'),
        body: buildBody(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Semantics(
          child: new FloatingActionButton(
            onPressed: () {
              getImage();
            },
            tooltip: 'Add New Entry',
            child: new Icon(Icons.camera_alt_rounded),
          ),
          button: true,
          enabled: true,
          onTapHint: 'Select an image',
        ));
  }
}
