import 'package:flutter/material.dart';
import 'package:witcher_notes/widgets/checkbox.dart';
import '../extenstion.dart';
import 'package:auto_size_text/auto_size_text.dart';


//обёртка над стейтлесвиджетом и возврат кнопки
class CheckString extends StatefulWidget {
  final String? text;
  final bool isSub;
  final bool isChecked;
  final Function(bool)? onTapCallback;
  //final ButtonStyle? style;

  CheckString({
    Key? key,
    this.text,
    required this.isSub, required this.isChecked, this.onTapCallback,
    //this.style,
  }) : super(key: key);


  @override
  State<CheckString> createState() => _CheckCheckStringState();
}

class _CheckCheckStringState extends State<CheckString>
{
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: calculateSize(context,8)),
      child:
      Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: calculateSize(context,12.0)),
            child: CheckWitcherBox(sizeChanger: 0.35,isTapped: widget.isChecked, onTapCallback: (value)
              {
                isTapped = !isTapped;
                setState(() {
                  widget.onTapCallback!(isTapped);
                });
              },),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: calculateSize(context,2.0)),
            child: Container(
              constraints: BoxConstraints(maxWidth: calculateSize(context,300.0)),
              child: AutoSizeText(widget.text??"Example text.",maxLines: 5, overflow: TextOverflow.ellipsis,
                style: widget.isSub?
                Theme.of(context).textTheme.bodyMedium:
                Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ],
      )
    );
  }
}

Widget buildPositionedContainer(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(calculateSize(context, 5)),
    child: Container(
      width: calculateSize(context, 25),
      height: calculateSize(context, 25),
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Container(
          width: calculateSize(context, 20),
          height: calculateSize(context, 20),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    ),
  );
}