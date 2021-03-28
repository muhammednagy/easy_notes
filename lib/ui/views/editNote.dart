import 'package:flutter/material.dart';
import 'package:easy_notes/models/note.dart';
import 'package:provider/provider.dart';
import 'package:easy_notes/services/api/CRUDModel.dart';

class EditNote extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Note note;

  EditNote({@required this.note});

  @override
  Widget build(BuildContext context) {
    var noteProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(
          child: Text('Edit Note'),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await noteProvider.removeNote(note.id);
              Navigator.pop(context);
            },
          ),
        ],
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
                  initialValue: note.title,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Note Title';
                    }
                  },
                  onSaved: (value) => note.title = value),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    maxLines: null,
                    minLines: 30,
                    initialValue: note.content,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Note',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSaved: (value) => note.content = value),
              )),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    note.dateLastEdited = DateTime.now();
                    await noteProvider.updateNote(note, note.id);
                    Navigator.pop(context);
                  }
                },
                child:
                    Text('Update Note', style: TextStyle(color: Colors.white)),
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
