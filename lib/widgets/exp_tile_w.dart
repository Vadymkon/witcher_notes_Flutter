import 'package:flutter/material.dart';
import 'package:witcher_notes/widgets/border_witcher.dart';
import 'package:witcher_notes/widgets/description.dart';
import 'package:witcher_notes/widgets/task_widget.dart';
import '../extenstion.dart';
import '../main.dart';
import '../model/note.dart';
import '../model/subnote.dart';
import '../pages/dialogs/add_notes.dart';
import '../pages/dialogs/settings.dart';
import 'package:provider/provider.dart';

import 'border_witcher_2.dart';

class ExpTileW extends StatefulWidget {
  late final bool? isTapped;
  final String? type;
  final String titleOfDirectory;
  final Note note;
  final List<SubNote> subnotes;
  //final ButtonStyle? style;

  ExpTileW({
    Key? key,
    this.isTapped, this.type,
    required this.note, required this.subnotes,
    required this.titleOfDirectory
    // this.style,
  }) : super(key: key);

  @override
  State<ExpTileW> createState() => _ExpTileWState();
}

class _ExpTileWState extends State<ExpTileW>
{
  // double multi = 1;
  bool isTapped = false;
  String type = "main";
  @override
  Widget build(BuildContext context) {
    if (widget.type != null) type = widget.type!;
    // if (widget.sizeChanger != null) multi = widget.sizeChanger!;
    return GestureDetector(
      onTap: (){
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: ExpansionTile(
        onExpansionChanged: (bool expanded){
          setState(() {
            isTapped = expanded;
          }); },
        title:
        Container(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2), child:
        BoardIcon(Somethink:
          TaskW(colorik: type,choose: isTapped,
               note: widget.note
          ), taskColor: type,)),
        children: <Widget>[
          GestureDetector(
            onTap: (){
              addNote(context,widget.titleOfDirectory,widget.note,Provider.of<stateApp>(context,listen: false).subnotes.where((element) => element.idParent == widget.note.id).toList());
            },
            child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: descriptionW(note: widget.note, subnotes: widget.subnotes,)),
          ),
        ],
        tilePadding: EdgeInsets.zero,
      ),
    );
  }
}


class BoardIcon extends StatefulWidget {
  final String taskColor;
  final Widget Somethink;
  //final ButtonStyle? style;

  BoardIcon({
    Key? key,
    required this.taskColor,
    required this.Somethink,
    // this.style,
  }) : super(key: key);

  @override
  State<BoardIcon> createState() => _BoardIconState();
}

class _BoardIconState extends State<BoardIcon>
{
  // double multi = 1;
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    // if (widget.sizeChanger != null) multi = widget.sizeChanger!;
    return Stack(
      children: [
        widget.Somethink,
        Positioned.fill(
          left: 0,
          right: calculateSize(context, 383),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: calculateSize(context, 50)),
            child: Container(
              color: ColorsForWidgets[widget.taskColor],
            ),
          ),
        ),
      ],
    );
  }
}
