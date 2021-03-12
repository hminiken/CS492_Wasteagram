
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/entry_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/widgets/home_screen_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';



class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override 
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      print("completed");
      setState(() {});
    });
    // loadJournal();
  }


    void pushViewEntry(BuildContext context, int index) {
    Navigator.of(context).pushNamed(EntryScreen.routeName);
    //     arguments: ScreenArguments(journal.entries[index].entryTitle,
    // journal.entries[index].entryText, journal.entries[index].entryDate));
  }

  void pushNewEntry(BuildContext context)  {
     

    Navigator.of(context).pushNamed(NewPostScreen.routeName, 
     arguments: ScreenArguments(image));
  }

   File image;
  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);




    setState(() {
      pushNewEntry(context);
    });
  }


  //  Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }


  Widget build(BuildContext context) {
    var TextTheme = Theme.of(context).textTheme;
   
    return Scaffold(
      // key: _scaffoldKey,
      appBar: wasteagramAppBar(context, 'Wasteagram'),

      body: 
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('waste_entries').snapshots(),
        builder: (content, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var post = snapshot.data.documents[index];
                Timestamp entryDate = post['entry_date'];
                DateTime datetime = entryDate.toDate();
                String strDate = DateFormat('EEEE, MMMM d, ' 'yyyy').format(datetime);
                return ListTile(
                  title: Text(strDate),
                  trailing: Text(post['num_items'].toString(), style: TextTheme.headline5,),
                );
              },
            );
          }
        }),
        




          // child: 
          // ListView.builder(
          //     // itemCount: journal.entries.length,
          //     // itemBuilder: (context, index) {
          //     //   print('creating item $index');
          //     //   return ListTile(
          //     //     // leading: FlutterLogo(),
          //     //     // trailing: Icon(Icons.more_horiz),
          //     //     title: Text('${journal.entries[index].entryTitle}'),
          //     //     subtitle: Text('${journal.entries[index].entryText}'),
          //     //     onTap: (){                    
          //     //       pushViewEntry(context, index);
          //     //     },
          //     //   );
          //     // }
          //     ),
        

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          getImage();
          
        },
        tooltip: 'Add New Entry',
        child: new Icon(Icons.camera_alt_rounded),
      ),
    );
    }
  

}