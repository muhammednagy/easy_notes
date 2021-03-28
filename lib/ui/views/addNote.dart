import 'package:flutter/material.dart';
import 'package:easy_notes/models/note.dart';
import 'package:provider/provider.dart';
import 'package:easy_notes/services/api/CRUDModel.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  String productType;
  String title;
  String content;

  @override
  Widget build(BuildContext context) {
    var noteProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(
          child: Text('Add Note'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Note Title',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Note Title';
                    }
                  },
                  onSaved: (value) => title = value),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    maxLines: null,
                    minLines: 30,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Note',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSaved: (value) => content = value),
              )),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await noteProvider.addNote(Note(
                        title: title,
                        content: content,
                        dateCreated: DateTime.now(),
                        dateLastEdited: DateTime.now()));
                    Navigator.pop(context);
                  }
                },
                child: Text('add Note', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
