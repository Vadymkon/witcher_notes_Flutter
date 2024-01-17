import 'package:flutter/material.dart';
import 'package:witcher_notes/pages/dialogs/add_notes.dart';
import 'package:witcher_notes/widgets/shield.dart';
import 'package:witcher_notes/widgets/shieldLevel.dart';
import 'package:witcher_notes/widgets/task_widget.dart';
import '../extenstion.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TaskListW extends StatefulWidget {
  final double? sizeChanger;
  final String? colorik;
  final bool? choose;
  final String? title;

  TaskListW({
    Key? key, this.sizeChanger, this.colorik,this.choose, this.title,
    //this.style,
  }) : super(key: key);

  @override
  State<TaskListW> createState() => _TaskListWState();
}

class _TaskListWState extends State<TaskListW>
{
  double multi = 1;
  bool isTapped = false;
  Color taskColor = Colors.red;
  String title = "Witcher Quests";

  @override
  Widget build(BuildContext context) {
    if (widget.choose != null) isTapped = widget.choose!;
    if (widget.sizeChanger != null) multi = widget.sizeChanger!;
    if (widget.colorik != null) taskColor= ColorsForWidgets[widget.colorik]!;
    if (widget.title != null) title = widget.title!;
    return GestureDetector(
      onLongPress: (){
        addNote(context, title,null,null);
      },
      child: Stack(
        children: <Widget>[
          /*
          Positioned.fill(
            left: isTapped? -20: -320,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 50),
              child: ShaderMask( shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [taskColor, Colors.transparent],
                  stops: [0, 0.9],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
                child: Container(
                  color: taskColor,

                ),
              ),
            ),
          ),

           */

          Container(
            color: isTapped? Colors.transparent: Theme.of(context).dividerColor,
            child: Container(
              padding: EdgeInsets.only(bottom: calculateSize(context, 8*1.15),top: calculateSize(context, 1.2*12),
                  left: calculateSize(context, 23),right: calculateSize(context, 8)),
              decoration: BoxDecoration(
                  border: Border.all(width:calculateSize(context, 5),
                      color: Theme.of(context).canvasColor.withOpacity(
                      calculateSize(context, 0.5)))
              ),
              child: Row(
                children: [
                  Expanded(child: AutoSizeText(
                    maxLines: 1,title.toUpperCase(),
                    style:
                    isTapped?
                    Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: calculateSize(context, 22))
                    : Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: calculateSize(context, 22),
                          color: Theme.of(context).secondaryHeaderColor,),
                    overflow: TextOverflow.ellipsis,)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
