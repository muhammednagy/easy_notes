import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';
import '../../models/note.dart';
import 'api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Note> notes;


  Future<List<Note>> fetchNotes() async {
    var result = await _api.getDataCollection();
    notes = result.docs
        .map((doc) => Note.fromMap(doc.data(), doc.id))
        .toList();
    return notes;
  }

  Stream<QuerySnapshot> fetchNotesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Note> getNoteById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Note.fromMap(doc.data(), doc.id) ;
  }


  Future removeNote(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateNote(Note data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addNote(Note data) async{
    await _api.addDocument(data.toJson()) ;
    return ;
  }


}