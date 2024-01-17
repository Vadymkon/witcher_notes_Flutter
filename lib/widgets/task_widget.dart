import 'package:flutter/material.dart';
import 'package:witcher_notes/widgets/shield.dart';
import 'package:witcher_notes/widgets/shieldLevel.dart';
import '../extenstion.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../model/note.dart';

Map <String, Color> ColorsForWidgets =
{
  'red' : Colors.red,
  'main' : Color(0xFF8a5926),
  'secondary' : Color(0xFF444010),
  'witcher' : Color(0xFF0f5716),
  'treasure' : Color(0xFF412016),
  'empty' : Colors.transparent
};

class TaskW extends StatefulWidget {
  final double? sizeChanger;
  final String? colorik;
  final bool? choose;
  final Note note;

  TaskW({
    Key? key, this.sizeChanger, this.colorik,this.choose, required this.note,
    //this.style,
  }) : super(key: key);

  @override
  State<TaskW> createState() => _TaskWState();
}

class _TaskWState extends State<TaskW>
{
  double multi = 1;
  bool isTapped = false;
  Color taskColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    if (widget.choose != null) isTapped = widget.choose!;
    if (widget.sizeChanger != null) multi = widget.sizeChanger!;
    if (widget.colorik != null) taskColor= ColorsForWidgets[widget.colorik]!;
    return Stack(
      children: <Widget>[
        //заливка цветом темы градиент
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

        Container(
          padding: EdgeInsets.only(bottom: 4,top: 6,left: 9,right: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.02))
          ),
          child: Row(
            children: [
              SLevel(level: 100, note: widget.note,customcolor:  widget.note.directory != 'Failed' ? null:Color(0xFFf04949),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:  calculateSize(context, 12.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(maxLines: 1,widget.note.title ?? "Example Witcher task.",
                      style: widget.note.directory != 'Failed' ? Theme.of(context).textTheme.bodyLarge :
                      Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFFf04949)),
                      overflow: TextOverflow.ellipsis,),
                    AutoSizeText(maxLines: 1,widget.note.place ?? "Novigrad",
                      style: widget.note.directory != 'Failed' ? Theme.of(context).textTheme.bodyMedium :
                      Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF6e0e02)),
                      overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
