import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/res/strings.dart';

import 'data/note.dart';

class Notes extends StatefulWidget {

  List<Note> notes = [
  Note('First Note', DateTime.now()),
  Note('Second Note', DateTime.now()),
  Note(Strings.lorem, DateTime.now()),
  Note('Forth note', DateTime.utc(2020))];

  @override
  State<StatefulWidget> createState() {
    return NotesState();
  }
}


class NotesState extends State<Notes> {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      key: GlobalKey(),
      crossAxisCount: 2,
    scrollDirection: Axis.vertical,
    mainAxisSpacing: 10,
    crossAxisSpacing: 20,
    children: [
      _noteItems()
    ],);
  }

  _noteItems() {
    List<Widget> widgets = [];
    for (Note note in widget.notes) {
      widgets.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _noteContent(note.content),
          _noteDate(note.date)
        ],
      ));
    }
  }

  _noteContent(String content) {
    return Expanded(
      child: Text(content, maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black45)),
    );
  }

  _noteDate(DateTime date) {
    return Text(date.toString());
  }
}