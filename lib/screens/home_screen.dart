import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/screen_argument_models.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  // FirebaseAnalytics().setCurrentScreen(screenName: 'Example1');

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void pushNewEntry(BuildContext context) {
    Navigator.of(context)
        .pushNamed(NewPostScreen.routeName, arguments: NewPostArguments(image));
  }

  File image;

  void selectImage() async {
    try {
      var _permissionGranted = await Permission.storage.request();
      if (_permissionGranted.isUndetermined) {
        _permissionGranted = await Permission.storage.request();
        if (_permissionGranted.isDenied) {
          print('Location service permission not granted. Returning.');
          //  Navigator.of(context).pop();
          return;
        }
      }
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      image = File(pickedFile.path);
      setState(() {
        pushNewEntry(context);
      });
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wasteagramAppBar(context, 'Wasteagram'),
        body: buildBody(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Semantics(
          child: new FloatingActionButton(
            onPressed: () {
              selectImage();
              print("Sending an error!");
              throw StateError('minikenh Extra Credit Example Error!');
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
