import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:witcher_notes/db/notes_database.dart';
import '../db/subnotes_database.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../model/note.dart';
import '../model/subnote.dart';
import '../widgets/elev_button_wrapper.dart';
import 'dialogs/settings.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';
import 'package:witcher_notes/widgets/note_card_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:witcher_notes/widgets/note_form_widget.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  late List<SubNote> subnotes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    SubNotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();
    this.subnotes = await SubNotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).menu),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
        actions: [
          IconButton(onPressed: () {openSettings(context);}, icon: Icon(Icons.settings, color: Theme.of(context).primaryColor,))
        ],
      ),
      body:
      SingleChildScrollView(
        child: Text('OAO'),
      ),
    );
  }

}