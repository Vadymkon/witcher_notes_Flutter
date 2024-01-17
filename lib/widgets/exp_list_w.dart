import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:witcher_notes/pages/dialogs/add_notes.dart';
import 'package:witcher_notes/widgets/description.dart';
import 'package:witcher_notes/widgets/task_list.dart';
import 'package:witcher_notes/widgets/task_widget.dart';
import '../db/notes_database.dart';
import '../extenstion.dart';
import '../main.dart';
import '../model/note.dart';
import '../model/subnote.dart';
import '../pages/menu.dart';
import 'exp_tile_w.dart';
import 'package:provider/provider.dart';

// stores ExpansionPanel state information
/*
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

 */


class ExpList extends StatefulWidget {
  final String name;
  final String? type;

  const ExpList({super.key, required this.name, this.type,
    });
  //
  // Future addNote() async {
  //   final note = Note(
  //     directory      : directory   ,
  //     nameOfShield   : nameOfShield,
  //     isImportant    : isImportant ,
  //     ai             : ai ,
  //     level          : level       ,
  //     title          : title       ,
  //     place          : place       ,
  //     dateStart      : DateTime.now(),
  //     deadline       : deadline    ,
  //     completedID    : completedID ,
  //     done           : done        ,
  //     description    : description ,
  //   );
  //
  //   await NotesDatabase.instance.create(note);
  // }

  @override
  State<ExpList> createState() =>
      _ExpListState();
}

class _ExpListState extends State<ExpList> {


  //late
  // late final _data = [];//generateItems(5);//_MenuState //NotesDatabase.instance.readAllNotes();

  // @override
  // void initState() {
  //   super.initState();
  //   if (_data == null) {
  //     _data = []; // Initialize the variable only if it's null
  //   }
  // }

 String type = "";
  bool isTapped = false;

 void initState() {
   super.initState();
   isTapped = widget.name == 'Main Quests';
 }
  @override
  Widget build(BuildContext context) {
    if (widget.type != null) type = widget.type!;
   //_data = widget.notes.where((element) => element.directory == widget.name);

    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {

    return Column(
      children: [
        ExpansionTile(
          initiallyExpanded : isTapped,
          onExpansionChanged: (bool expanded){
            setState(() {
              isTapped = expanded;
            }); },
          tilePadding: EdgeInsets.zero,
            title: BoardIcon(Somethink: Container(
                child: TaskListW(
                    title: widget.name,
                    colorik: type!=""?type:'main',
                    choose: isTapped)),
                  taskColor: type!=""?type:'main',),
            children: [

              //plusButton
              if (ColorsForWidgets[type]!= Colors.transparent && Provider.of<stateApp>(context).isPlusButton) ...[
              MaterialButton(
                splashColor: type!=""?
                ColorsForWidgets[type]?.withOpacity(0.95)
                    :ColorsForWidgets['main']?.withOpacity(0.2),
                highlightColor: type!=""?
                ColorsForWidgets[type]?.withOpacity(0.95)
                    :ColorsForWidgets['main']?.withOpacity(0.2),
                onPressed: () async {

                  // print('PRINTED: ${Provider.of<stateApp>(context, listen: false).notes.length}');
                  setState(() {
                    addNote(context, widget.name, null, null);
                    Provider.of<stateApp>(context,listen: false).refreshNotes();
                  });



                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30)),
                  child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              color: type!=""?
                              ColorsForWidgets[type]?.withOpacity(0.15)
                                  :ColorsForWidgets['main']?.withOpacity(0.2),
                             // color: Colors.transparent,
                              padding: EdgeInsets.all(calculateSize(context, 8)),
                              child: Icon(CupertinoIcons.plus),
                            )),
                      ],
                    ),
                ),
              ),],



        // if (_data != [])
          ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: Provider.of<stateApp>(context, listen: false).getNotesByDir(widget.name).length,
          itemBuilder: (context, index) {
            Note timeNote = Provider.of<stateApp>(context,listen: false).getNotesByDir(widget.name)[index];
            // print('PRINTED: ${Provider.of<stateApp>(context, listen: false).getNotesByDir(widget.name).length}');
            if (timeNote.directory == 'Failed' || timeNote.directory == 'Completed')
              return ExpTileW(
                type: type,
                note: timeNote,
                subnotes: Provider.of<stateApp>(context).subnotes.where((element) => element.idParent == timeNote.id).toList(),
                titleOfDirectory: widget.name,
                );
            else {
              return Dismissible(
              onDismissed: (value){
                setState(() {
                   NotesDatabase.instance.delete(timeNote.id!);
                   Provider.of<stateApp>(context, listen: false).refreshNotes();
                });
              },
                key: Key(timeNote.title),
                //Key(Provider.of<Bill>(context).users_list[index])
                child: ExpTileW(
                  type: type,
                  note: timeNote,
                  subnotes: Provider.of<stateApp>(context).subnotes.where((element) => element.idParent == timeNote.id).toList(),
                  titleOfDirectory: widget.name,
                ));}

          },
        )


          ],
        ),
      ],
    );
  }
}