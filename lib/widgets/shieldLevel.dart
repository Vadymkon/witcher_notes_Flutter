import 'package:flutter/material.dart';
import 'package:witcher_notes/widgets/shield.dart';
import '../db/notes_database.dart';
import '../extenstion.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/note.dart';

class SLevel extends StatefulWidget {
  final double? sizeChanger;
  final int level;
  final Note note;
  final Color? customcolor;
  //final ButtonStyle? style;

  SLevel({
    Key? key, this.sizeChanger, required this.level, required this.note, this.customcolor,
    //this.style,
  }) : super(key: key);

  @override
  State<SLevel> createState() => _SLevelState();
}

class _SLevelState extends State<SLevel>
{
  double multi = 1;
  bool isTapped = false;
  String nameofshield = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameofshield = widget.note.nameOfShield ?? 'greentext';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sizeChanger != null) multi = widget.sizeChanger!;
    return InkWell(
      onTap:() {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Stack(
        children: [
          Shield(imageName: nameofshield ,width: calculateSize(context,220*0.4),height: calculateSize(context,150*0.4),
              onChangedCallback: (value){
                setState(() async {
                  nameofshield = value;
                  print('THIS IS : $nameofshield');

                  final note = widget.note!.copy(
                    nameOfShield: nameofshield,
                  );
                  await NotesDatabase.instance.update(note);
                  await Provider.of<stateApp>(context, listen: false).refreshNotes();
                });
              },),
          Positioned(
          top: calculateSize(context,14),
          left: calculateSize(context,70),
          child: AutoSizeText(widget.level.toString(),
            style: widget.customcolor == null ? Theme.of(context).textTheme.labelMedium
            :  Theme.of(context).textTheme.labelMedium!.copyWith(color: widget.customcolor)

            ,)
          ),
          if (widget.note.isImportant) ...[
            Positioned(left: calculateSize(context,2.4),bottom: calculateSize(context,6),
                child: Image.asset('assets/!.png',scale: calculateSize(context,4.3),)),
          ]
    ],
    ));
  }
}
