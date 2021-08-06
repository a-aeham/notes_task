import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatelessWidget {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notes.add({
            'title': titleController.text,
            'content': contentController.text,
          }).whenComplete(() => Navigator.pop(context));
        },
        child: Icon(Icons.save_rounded),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: contentController,
                maxLines: null,
                decoration: InputDecoration(hintText: 'Content ..'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
