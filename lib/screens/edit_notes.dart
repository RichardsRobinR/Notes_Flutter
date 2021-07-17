import 'package:flutter/material.dart';
import 'package:login_demo/logicv2.dart';
import 'package:login_demo/screens/notes.dart';
import 'package:provider/provider.dart';

class EditNotes extends StatefulWidget {
  String title;
  String description;
  String docID;
  var choice;

  EditNotes(
      {required this.title,
      required this.description,
      required this.docID,
      required this.choice});

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController _textcontroller = TextEditingController();

  TextEditingController _passwordtextcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textcontroller.text = this.widget.title;
    _passwordtextcontroller.text = this.widget.description;
  }

  Future<T> pushPage<T>() {
    return checkCondition();
  }

    checkCondition() {
    switch (this.widget.choice) {
      case Execution.create:
        {
          if (_textcontroller.text.isNotEmpty ||
              _passwordtextcontroller.text.isNotEmpty) {
            context.read<LogicV2>().createNote(
                title: this._textcontroller.text,
                description: this._passwordtextcontroller.text);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        }
        break;

      case Execution.update:
        {
          if (_textcontroller.text.isNotEmpty ||
              _passwordtextcontroller.text.isNotEmpty) {
            context.read<LogicV2>().updateItem(
                title: this._textcontroller.text,
                description: this._passwordtextcontroller.text,
                docId: this.widget.docID);
            Navigator.pop(context);
          }
          else {
            Navigator.pop(context);
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pushPage,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon:  Icon(Icons.arrow_back),onPressed: () {
            checkCondition();
          },),

          iconTheme: IconThemeData(
            color: Colors.blue
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  context.read<LogicV2>().deleteItem(docId: this.widget.docID);
                  Navigator.pop(context);
                },
                child: Text('Delete')),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(

                controller: _textcontroller,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _passwordtextcontroller,
                  decoration: InputDecoration(
                    hintText: 'Note',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

