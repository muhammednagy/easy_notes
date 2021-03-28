import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_notes/models/note.dart';
import 'package:easy_notes/services/api/CRUDModel.dart';
import 'package:easy_notes/ui/widgets/noteCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Note> notes;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addNote');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home')),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: noteProvider.fetchNotesAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                notes = snapshot.data.docs
                    .map((doc) => Note.fromMap(doc.data(), doc.id))
                    .toList();
                return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (buildContext, index) =>
                        NoteCard(noteDetails: notes[index]),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
    ;
  }
}
