import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login_demo/logicv2.dart';
import 'package:login_demo/screens/edit_notes.dart';
import 'package:login_demo/screens/login_screen.dart';
import 'package:provider/provider.dart';


class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

late String userUid;
 late String pic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     userUid = context.read<LogicV2>().checkCurrentUser();



    //userUid = 'TRTRaY5rECgzAychcw9xskWadUm1';
  }



  @override
  Widget build(BuildContext context) {

    pic = context.read<LogicV2>().getGoogleProfilePic().toString();
    //final CollectionReference usersStream = FirebaseFirestore.instance.collection('users').doc(context.read<LogicV2>().userUid).collection('notes');
    return Scaffold(
      //backgroundColor: Colors.amber,

      appBar: AppBar(
        elevation: 0,
        title: Text('Notes .',style: TextStyle(
          color: Colors.blue
        ),),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              context.read<LogicV2>().signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text('LogOut'),
          ),
          SizedBox(width: 10),
         // AboutDialog(),
         CircleAvatar(

           backgroundImage: Image.network(pic).image,
         ),
          SizedBox(width: 10)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  context.watch<LogicV2>().readDataStream(userUid: userUid),
        builder: (context, snapshot) {

          if (!snapshot.hasData){
            print('test phrase');
            return Text("Loading.....");
          }

          return  StaggeredGridView.countBuilder(
             crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              staggeredTileBuilder: (i) => StaggeredTile.fit(2),

            itemCount:snapshot.data!.docs.length,
            itemBuilder: (context,index) {

                var noteInfo = snapshot.data!.docs[index];
                String docID = snapshot.data!.docs[index].id;
                String title = snapshot.data!.docs[index]['title'];
                String description = noteInfo['description'];


            return InkWell(
              onTap: () {

                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotes(title: title, description: description, docID: docID, choice: Execution.update,)));
                });
                print(docID);
                print(snapshot.data!.docs[0]['title']);

              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(title,

                        minFontSize: 12,style: TextStyle(
                        fontSize: 25
                      ),),
                      AutoSizeText(description,
                          maxLines: 10,
                          minFontSize: 20,style :TextStyle(
                          fontSize: 20
                      ),),
                    ],
                  ),
                ),
              ),
            );
          } );
        }
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.add), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotes(docID: '', description: '', title: '', choice: Execution.create,)));
        context.read<LogicV2>().getGoogleProfilePic();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}


class AvatharMenu extends StatelessWidget {
  const AvatharMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        color: Colors.indigoAccent,
      ),
    );
  }
}


