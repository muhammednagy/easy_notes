import 'package:easy_notes/models/note.dart';
import 'package:easy_notes/ui/views/editNote.dart';
import 'package:flutter/material.dart';


class NoteCard extends StatelessWidget {
  final Note noteDetails;

  NoteCard({@required this.noteDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => EditNote(note: noteDetails)));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        noteDetails.title??'',
                        style: TextStyle(
                            fontSize: 22,
                        ),
                      ),
                      Text(
                        noteDetails.content??'',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

