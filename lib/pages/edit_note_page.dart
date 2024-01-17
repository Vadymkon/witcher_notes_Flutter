/*import 'package:flutter/material.dart';
import 'package:witcher_notes/db/notes_database.dart';
import 'package:witcher_notes/model/note.dart';
import 'package:witcher_notes/widgets/note_form_widget.dart';

import '../db/notes_database.dart';

DateTime DateInsteadNull = DateTime(3000);

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
// late int?       id             ;
   late String     directory      ;
   late String     nameOfShield   ;
   late bool       isImportant    ;
   late bool       ai             ;
   late int        level          ;
   late String     title          ;
   late String     place          ;
// late DateTime   dateStart      ;
   late DateTime   deadline       ;
   late int        completedID    ;
   late bool       done           ;
   late String     description    ;

  @override
  void initState() {
    super.initState();

 //   isImportant = widget.note?.isImportant ?? false;
  //  number = widget.note?.number ?? 0;
   // title = widget.note?.title ?? '';
    //description = widget.note?.description ?? '';

//  id             = widget.note?.id             ?? '';
    directory      = widget.note?.directory      ?? '';
    nameOfShield   = widget.note?.nameOfShield   ?? '';
    isImportant    = widget.note?.isImportant    ?? false;
    ai             = widget.note?.ai             ?? false;
    level          = widget.note?.level          ?? 0;
    title          = widget.note?.title          ?? '';
    place          = widget.note?.place          ?? '';
//  dateStart      = widget.note?.dateStart      ?? '';
    deadline       = widget.note?.deadline       ?? DateInsteadNull;
    completedID    = widget.note?.completedID    ?? 0;
    done           = widget.note?.done           ?? false;
    description    = widget.note?.description    ?? '';


  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
    ),
    body:Container(),
    /*
    Form(
      key: _formKey,
      child: NoteFormWidget(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description,
        onChangedImportant: (isImportant) =>
            setState(() => this.isImportant = isImportant),
        onChangedNumber: (number) => setState(() => this.number = number),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),

    */
  );
/*
  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

 */

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
            // id             : id,
            directory      : directory   ,
            nameOfShield   : nameOfShield,
            isImportant    : isImportant ,
            ai             : ai ,
            level          : level       ,
            title          : title       ,
            place          : place       ,
            // dateStart      : dateStart   ,
            deadline       : deadline    ,
            completedID    : completedID ,
            done           : done        ,
            description    : description ,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      directory      : directory   ,
      nameOfShield   : nameOfShield,
      isImportant    : isImportant ,
      ai             : ai ,
      level          : level       ,
      title          : title       ,
      place          : place       ,
      dateStart      : DateTime.now(),
      deadline       : deadline    ,
      completedID    : completedID ,
      done           : done        ,
      description    : description ,
    );

    await NotesDatabase.instance.create(note);
  }
}

 */