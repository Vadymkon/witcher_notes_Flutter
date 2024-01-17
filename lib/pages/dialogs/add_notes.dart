import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:witcher_notes/db/subnotes_database.dart';
import 'package:witcher_notes/pages/dialogs/changename.dart';
import 'package:witcher_notes/widgets/border_witcher.dart';
import 'package:witcher_notes/widgets/checkbox.dart';
import 'package:witcher_notes/widgets/shield.dart';
import 'package:witcher_notes/widgets/textfieldwrapper.dart';
import '../../db/notes_database.dart';
import '../../extenstion.dart';
import '../../main.dart';
import 'package:witcher_notes/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../model/subnote.dart';
import '../../widgets/dropdown_wrapper.dart';
import '../../widgets/elev_button_wrapper.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../widgets/message_alert.dart';
import '../menu.dart';

class AddNoteDialog extends StatefulWidget {
  final Note? noteAsIs;
  final String directoryStart;
  final List<SubNote>? subnotesAsIs;
  final stateApp stateAppInstance;
  // final BuildContext context;
  AddNoteDialog({this.noteAsIs, this.subnotesAsIs,
    required this.directoryStart, required this.stateAppInstance});

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {

  bool _isTapped = false; //detail-menu-panel
  String _deadline = '';
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController placeController = new TextEditingController();
  bool isImportant = false;
  List <String> _dialogElementsStr = [];
  List <bool> _dialogElementsBool = [];
  List <int?> _dialogElementsID = [];
  List <int> indexesToRemove = [];
  late String nameOfShield = '';
  late int completedID;
  late DateTime deadline;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.noteAsIs?.title ?? '';
    descriptionController.text = widget.noteAsIs?.description ?? '';
    placeController.text = widget.noteAsIs?.place ?? 'Novigrad';
    isImportant =                         widget.noteAsIs?.isImportant         ??  false;
    if (widget.subnotesAsIs != null)
      {
    _dialogElementsStr.addAll([for (var subnote in widget.subnotesAsIs!) subnote.title]);
    _dialogElementsBool.addAll([for (var subnote in widget.subnotesAsIs!) subnote.isActive]);
    _dialogElementsID.addAll([for (var subnote in widget.subnotesAsIs!) subnote.idSub]);
      }
    completedID = -1;
    nameOfShield =                           widget.noteAsIs?.nameOfShield        ?? 'greentext';
    deadline =                             widget.noteAsIs?.deadline            ??   DateTime(3000);
    _deadline = deadline != DateTime(3000)?  DateFormat('yyyy-MM-dd – kk:mm').format(deadline ): '';
  }

  @override
  Widget build(BuildContext context) {
  print(widget.noteAsIs?.place);
    //easy to manipulate template
    String directory =                             widget.noteAsIs?.directory          ?? widget.directoryStart;

    // bool isImportant =                         widget.noteAsIs?.isImportant         ??  false;
    bool ai =                                  widget.noteAsIs?.ai                  ??  false;
    int level =                                     widget.noteAsIs?.level               ??  100;
        // titleController =         TextEditingController(text: widget.noteAsIs?.title ?? '');
        // descriptionController =   TextEditingController(text: widget.noteAsIs?.description ?? '');
        // placeController =                   TextEditingController(text: widget.noteAsIs?.place  ?? 'Novigrad');
    // String title =                                  widget.noteAsIs?.title               ?? '';
    // String description =                            widget.noteAsIs?.description         ?? '';
    // String place =                                  widget.noteAsIs?.place               ?? 'Novigrad';
    // DateTime dateStart =                            widget.noteAsIs?.dateStart           ??   DateTime.now();

    // int completedID =                               widget.noteAsIs?.completedID         ??   0;
    bool done =                                     widget.noteAsIs?.done                ??   false;


    //_deadline = S.of(context).deadline;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 22.0))),
      ),
      shadowColor: Theme.of(context).primaryColor.withOpacity(0.27),//Colors.red,
      child: Padding(
        padding: EdgeInsets.all(calculateSize(context, 18.0)),
        child: Container(
          constraints: BoxConstraints(maxWidth: calculateSize(context, 300)),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 50.0))),
          ),
          ///MAKE NOTE AI
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, //spaceEvenly
                    children: [
                      AutoSizeText(
                        maxLines: 1,
                        S.of(context).makenote.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      // ElevButtonWrapper(onPressed: (){
                      //   Navigator.pop(context);
                      //   changename(context, '');
                      // }, child: AutoSizeText(S.of(context).ai),noPadding: false,)
                    ],
                  ),
                ),
                ///TITLE
                Padding(
                  padding: EdgeInsets.symmetric(vertical: calculateSize(context, 0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        maxLines: 1,
                        S.of(context).title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      borderWitcher(
                        child: TextField(
                          //
                          // onChanged: (value){
                          //   setState(() {
                          //     title = value;
                          //   });
                          // },
                          controller: titleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ///DESCRIPTION
                Padding(
                  padding: EdgeInsets.symmetric(vertical: calculateSize(context, 0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        maxLines: 1,
                        S.of(context).description,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      borderWitcher(
                        child: TextField(
                          // onChanged: (value){
                          //   setState(() {
                          //     description = value;
                          //   });
                          // },
                          controller: descriptionController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            /// THERE'S PLACE FOR DETAIL SETTINGS
                if (_isTapped) ...[
                // AutoSizeText('data'),
                  Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Shield(
                              imageName: nameOfShield,
                              width: calculateSize(context, 120),height: calculateSize(context, 100),
                              onChangedCallback: (value){
                                setState(() {
                                  nameOfShield = value;
                                  print('THIS IS : $nameOfShield');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      //IsImportant
                      Positioned(
                        right: calculateSize(context, 10),
                        top: calculateSize(context, 25),
                        child: Transform.scale(
                          scale: calculateSize(context, 1.1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(calculateSize(context, 8.0)),
                                child: AutoSizeText(
                                  maxLines: 1,
                                  S.of(context).is_important,
                                  // style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              GestureDetector(

                                  child: CheckWitcherBox(sizeChanger: 0.5, isTapped: isImportant,onTapCallback: (value)
                                  async {setState(() {
                                    isImportant = value;
                                  });
                                    }
                                    ,),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Directory
                  Padding(
                    padding: EdgeInsets.all(calculateSize(context, 5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: calculateSize(context, 8.0)),
                          child: AutoSizeText(
                            maxLines: 1,
                            S.of(context).directory,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        DropdownButtonExample(value: directory,list: listTitles.keys.toList(), onChangedCallback: (String value) {
                          directory = value;
                        }, ),
                      ],
                    ),
                  ),
                  //check fields
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: calculateSize(context, 8)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:calculateSize(context, 8)),
                        child: borderWitcher(
                          child: Padding(
                            padding: EdgeInsets.all(calculateSize(context, 8)),
                            child: Column(
                              children: [
                                Row(
                                  children: [

                                    /// PLUS_button
                                    Expanded(
                                      child: Container(
                                        child: ElevButtonWrapper(
                                          customcolor: Theme.of(context).primaryColor.withOpacity(0.2),
                                          onPressed: () async {
                                            String? newName = await changename(context, '');
                                            if (newName != null && newName != '') {
                                              setState(() {
                                                _dialogElementsStr.add(newName);
                                                _dialogElementsBool.add(false);
                                                _dialogElementsID.add(null);
                                              });
                                            }
                                          },
                                          child: Icon(CupertinoIcons.plus_app),
                                          noPadding: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                                Container(
                                  constraints: BoxConstraints(maxHeight: 250),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _dialogElementsStr?.length,
                                    itemBuilder: (context, index) {
                                      int reversedIndex = _dialogElementsStr!.length - index - 1;
                                      // if (reversedIndex<0) reversedIndex = 0;
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CheckWitcherBox(sizeChanger: 0.5, isTapped: _dialogElementsBool[index],
                                                    onTapCallback: (v){_dialogElementsBool[index] = v;
                                                    setState(() {
                                                      // for (int i = 0; i < _dialogElementsBool.length; i++) if (i!=index)
                                                      //   _dialogElementsBool[i] = false;

                                                    });
                                                    },),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String? newName = await changename(context, _dialogElementsStr[reversedIndex]);
                                                      if (newName != null && newName != '') {
                                                        setState(() {
                                                          _dialogElementsStr[reversedIndex] = newName;
                                                        });
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.all(calculateSize(context, 16)),
                                                      child: AutoSizeText(_dialogElementsStr[reversedIndex],
                                                          style: _dialogElementsBool[index]?Theme.of(context).textTheme.bodyMedium:Theme.of(context).textTheme.bodyLarge),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // print('object ${reversedIndex} in ${_dialogElementsStr.length} andIN ${_dialogElementsBool.length}');
                                                    _dialogElementsStr.removeAt(reversedIndex);
                                                    _dialogElementsBool.removeAt(reversedIndex);

                                                    if (_dialogElementsID[reversedIndex] != null) indexesToRemove.add(_dialogElementsID[reversedIndex]!);
                                                    _dialogElementsID.removeAt(reversedIndex);
                                                  });
                                                },
                                                child: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                                              ),
                                            ],
                                          ),
                                          if (index != _dialogElementsStr.length - 1) ...[
                                            Padding(
                                              padding: EdgeInsets.all(calculateSize(context, 10)),
                                              child: Transform.scale(
                                                scaleY: -1,
                                                child: Icon(
                                                  Icons.downloading_outlined,
                                                  color: Theme.of(context).primaryColor,
                                                  size: calculateSize(context, 25),
                                                ),
                                              ),
                                            )
                                          ] else ...[
                                            Padding(
                                              padding: EdgeInsets.all(calculateSize(context, 6)),
                                              child: Container(),
                                            ),
                                          ],
                                        ],
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: calculateSize(context, 0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AutoSizeText(
                          maxLines: 1,
                          S.of(context).place,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        borderWitcher(
                          child: TextField(
                            // onChanged: (value){
                            //   setState(() {
                            //     place = value;
                            //   });
                            // },
                            controller: placeController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                // open detail settings
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: ElevButtonWrapper(
                          customcolor: Theme.of(context).dividerColor,
                          onPressed: () async {
                              setState(() {
                                _isTapped = !_isTapped;
                              });
                          },
                          child: Icon(_isTapped ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp),
                          noPadding: false,
                        ),
                      ),
                    ),
                  ],
                ),

                //buttons
                Row(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: _deadline == '' ? 0.7 : 1,
                        child: ElevButtonWrapper(
                          customcolor: Theme.of(context).dividerColor,
                          onPressed: () async {
                            DateTime? selectedDateTime = await _selectDateTime(context);
                            deadline = selectedDateTime!;
                            // print(selectedDateTime);
                            if (selectedDateTime != null) {
                              setState(() {
                                _deadline = DateFormat('yyyy-MM-dd – kk:mm').format(selectedDateTime);
                              });
                            } else {
                              setState(() {
                                _deadline = '';
                                deadline = DateTime(3000);
                              });
                            }
                          },
                          child: AutoSizeText(
                            maxLines: 1,
                            _deadline == '' ? S.of(context).deadline : _deadline,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),

                    //Кнопка ОК
                    ElevButtonWrapper(
                      customcolor: Theme.of(context).dividerColor,
                      onPressed: () async {
                        String title = titleController.text;
                        String description = descriptionController.text;
                        String place = placeController.text;


                        // print(_dialogElementsBool);
                        for (int i = 0; i < _dialogElementsBool.length; i++) if (!_dialogElementsBool[i]){print('object'); completedID = i;} else break;
                        // print(completedID);

                        if (_deadline == '') deadline = DateTime(3000);

                        if (title.isEmpty) title = S.of(context).newnote + ' '+ (Random().nextInt(1000)+1).toString();
                        // ШАБЛОН
                        // var note = Note(
                        //   directory      : 'Secondary'        ,
                        //   nameOfShield   : 'greentext'        ,
                        //   isImportant    : false              ,
                        //   ai             : false              ,
                        //   level          : 100                ,
                        //   title          : ''                 ,
                        //   place          : 'Novigrad'         ,
                        //   dateStart      : DateTime.now()     ,
                        //   deadline       : DateTime(3000)     ,
                        //   completedID    : 0                  ,
                        //   done           : false              ,
                        //   description    : ''                 ,
                        // );
                        bool isUpdating = widget.noteAsIs != null;
                        if (isUpdating) {
                          final note = widget.noteAsIs!.copy(
                            directory: directory,
                            nameOfShield: nameOfShield,
                            isImportant: isImportant,
                            ai: ai,
                            level: level,
                            title: title,
                            place: place,
                            // dateStart      : dateStart     ,
                            deadline: deadline,
                            completedID: _dialogElementsBool.length - completedID -1 ,
                            done: done,
                            description: description,
                          );


                          await NotesDatabase.instance.update(note);

                          for (int i = 0; i< _dialogElementsStr.length; i++)
                          {
                            final snote = _dialogElementsID[i] != null ?
                            SubNote(
                                idSub:  _dialogElementsID[i]!,
                                idParent: note.id!,
                                isActive: _dialogElementsBool[i],
                                title: _dialogElementsStr[i])
                            :
                            SubNote(
                                idParent: note.id!,
                                isActive: _dialogElementsBool[i],
                                title: _dialogElementsStr[i]);

                            SubNotesDatabase.updateOrAddSubNote(snote);
                          }
                          //удаляем индексы сабноутов которые выделены на удаление
                          for ( int i = 0; i < indexesToRemove.length; i++) await SubNotesDatabase.instance.delete(indexesToRemove[i]);

                          await widget.stateAppInstance.refreshNotes();
                          if (note.directory == 'Completed') showImageWithSound(context, note.title, 2);
                          else if (note.directory == 'Failed') showImageWithSound(context, note.title, 1);
                          else showImageWithSound(context, note.title, 0);
                        }
                        else {
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
                            completedID    : _dialogElementsBool.length - completedID -1 ,
                            done           : done        ,
                            description    : description ,
                          );

                          print('NOTE IS ADDED with $title in $directory');
                          final createdNote = await NotesDatabase.instance.create(note);

                          for (int i = 0; i< _dialogElementsStr.length; i++)
                            {
                              final snote = _dialogElementsID[i] != null ?
                              SubNote(
                                  idSub:  _dialogElementsID[i]!,
                                  idParent: createdNote.id!,
                                  isActive: _dialogElementsBool[i],
                                  title: _dialogElementsStr[i])
                              :
                              SubNote(
                                  idParent: createdNote.id!,
                                  isActive: _dialogElementsBool[i],
                                  title: _dialogElementsStr[i])
                              ;
                              SubNotesDatabase.updateOrAddSubNote(snote);
                            }

                          //удаляем индексы сабноутов которые выделены на удаление
                          for ( int i = 0; i < indexesToRemove.length; i++) await SubNotesDatabase.instance.delete(indexesToRemove[i]);

                          await widget.stateAppInstance.refreshNotes();
                          if (note.directory == 'Completed') showImageWithSound(context, note.title, 2);
                          else if (note.directory == 'Failed') showImageWithSound(context, note.title, 1);
                          else showImageWithSound(context, note.title, 3);
                        }

                        Navigator.pop(context);
                      },
                      child: AutoSizeText(
                        maxLines: 1,
                        S.of(context).ok.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void addNote(BuildContext context, String directoryStart, Note? note, List<SubNote>? snotes ) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AddNoteDialog(directoryStart: directoryStart,
      stateAppInstance: Provider.of<stateApp>(context, listen: false),
      noteAsIs: note,
      subnotesAsIs: snotes,
    ),
  );
}


Future<DateTime?> _selectDateTime(BuildContext context) async {
  DateTime? date = await _selectDate(context);
  if (date == null) return null;
  TimeOfDay? time = await  _selectTime(context) ;
  // print(DateTime(date!.year, date.month, date.day, time!.hour, time.minute));
  // print(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime(date!.year, date.month, date.day, time!.hour, time.minute)));
  return DateTime(date!.year, date.month, date.day, time!.hour, time.minute);
}

Future<DateTime?> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000));
  if (picked != null) return picked;
}

Future<TimeOfDay?> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) return picked;
}
/*
 if (_isDialogOpen) ...[ ]
ListView.builder(
                shrinkWrap: true,
                itemCount: _dialogElements.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_dialogElements[index]),
                  );
                },
              ),
 */