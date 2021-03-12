import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ScreenArguments {
  final File image;
  ScreenArguments(this.image);
}

class NewPostScreen extends StatefulWidget {
  static const routeName = '/new-post';
  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  @override
  void initState() {
    super.initState();
    // loadJournal();
  }

  Widget build(BuildContext context) {

  final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    var TextTheme = Theme.of(context).textTheme;
    final formKey = GlobalKey<FormState>();

    void uploadImage() async {
      StorageReference storageReference = 
      FirebaseStorage.instance.ref().child('wasteagram_' + (DateTime.now().millisecondsSinceEpoch).toString() + '.jpg');
      StorageUploadTask uploadTask = storageReference.putFile(args.image);
      await uploadTask.onComplete;

      //get stored image url
      final url = await storageReference.getDownloadURL();
      print(url);
    }

    return Scaffold(
        appBar: wasteagramAppBar(context, 'New Post'),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Image.file(args.image, 
                  
                      width: MediaQuery.of(context).size.width * 0.85
                  )
                ]),
                SizedBox(height: 10),

                TextFormField(
                  // key: formKey,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextTheme.headline5,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "Number of Wasted Items"),
                  onSaved: (value) {
                    //Store value in some object
                    // journalEntry.entryTitle = value;
                    // print("Saved my val");
                  },
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: SizedBox(
                            width: double.infinity,
                            height: 75,
                            child: ElevatedButton.icon(
                              label: Text(""),
                              icon: Icon(Icons.cloud_upload_outlined),
                              onPressed: () {
                                //
                              },
                            ))))
              ],
            )));
  }
}
