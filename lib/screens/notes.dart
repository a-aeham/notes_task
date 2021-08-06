import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'addNotes.dart';

class Notes extends StatelessWidget {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  void deleteNote(DocumentSnapshot<Object?> document) {
    notes.doc(document.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNotes()));
        },
        child: Icon(Icons.edit_rounded),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notes.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.get('title')),
                subtitle: new Text(document.get('content')),
                trailing: IconButton(
                  icon: Icon(Icons.delete_rounded),
                  onPressed: () {
                    deleteNote(document);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
