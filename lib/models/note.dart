import 'dart:convert';

class Note {
  String id;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateLastEdited;
  bool isArchived;

  Note(
      {this.id,
      this.title,
      this.content,
      this.dateCreated,
      this.dateLastEdited,
      this.isArchived});

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
//      'id': id,  since id is auto incremented in the database we don't need to send it to the insert query.
      'title': utf8.encode(title),
      'content': utf8.encode(content),
      'date_created': epochFromDate(dateCreated),
      'date_last_edited': epochFromDate(dateLastEdited),
      'is_archived': isArchived //  for later use for integrating archiving
    };
    if (forUpdate) {
      data["id"] = this.id;
    }
    return data;
  }

  Note.fromMap(Map snapshot, String id)
      : id = id ?? '',
        content = snapshot['content'] ?? '',
        title = snapshot['title'] ?? '',
        dateCreated = snapshot['date_created'].toDate() ?? '',
        dateLastEdited = snapshot['date_last_edited'].toDate() ?? '',
        isArchived = snapshot['is_archived'] ?? false;

// Converting the date time object into timestamp
  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

  toJson() {
    return {
      "title": title,
      "content": content,
      "date_created": dateCreated,
      "date_last_edited": dateLastEdited,
      "is_archived": isArchived
    };
  }

  void archiveThisNote() {
    isArchived = true;
  }
}
