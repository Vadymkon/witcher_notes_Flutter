import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:witcher_notes/widgets/trapezoid.dart';
import '../extenstion.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../generated/l10n.dart';
import '../main.dart';
import '../model/note.dart';
import '../model/subnote.dart';
import '../pages/dialogs/add_notes.dart';
import 'checkbox.dart';
import 'checkstring.dart';
import 'failedDoneButtons.dart';
import 'package:provider/provider.dart';


//обёртка над стейтлесвиджетом и возврат кнопки
class descriptionW extends StatefulWidget {
  final Note note;
  final List<SubNote> subnotes;
  //final ButtonStyle? style;

  descriptionW({
    Key? key, required this.note, required this.subnotes,
    //this.style,
  }) : super(key: key);

  @override
  State<descriptionW> createState() => _descriptionWState();
}

class _descriptionWState extends State<descriptionW>
{
  double multi = 1;
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    int complID = widget.note.completedID;
    return Column(
      children: [

        //DateTime
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Opacity(
            opacity: 0.65,
            child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText('${S.of(context).dateStart} ${(DateFormat('yyyy-MM-dd \nkk:mm').format(widget.note.dateStart) ?? '05.09.2022')}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: calculateSize(context,18)),),
               if (widget.note.deadline != DateTime(3000)) AutoSizeText('${S.of(context).deadline} ${DateFormat('yyyy-MM-dd \nkk:mm').format(widget.note.deadline) ??'12.12.2023'}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: calculateSize(context, 19)),),
              ],
            ),
          ),
        ),

        //Checkbox-routes
        // Padding(
        //   padding: EdgeInsets.all(calculateSize(context,8.0)),
        //   child: Transform.scale(
        //       scale: 0.8,
        //       child: CheckWitcherBox()),
        // ),

        if(widget.subnotes.isNotEmpty && complID !=-1)...[
          //sub-notes
          if (complID >= 0 && complID+1 <widget.subnotes.length) CheckString(isSub: false,text: widget.subnotes[complID].title,isChecked: true,),
          if (complID+1 >= 0 && complID+1 <widget.subnotes.length) CheckString(isSub: true, text: widget.subnotes[complID+1].title,isChecked: false,),

        ],

        //FD-Buttons
        if (widget.note.directory != 'Failed' && widget.note.directory != 'Completed')
        Padding(
          padding: EdgeInsets.symmetric(vertical : calculateSize(context,8.0)),
          child: FDButtons(note:widget.note,stateAppInstance: Provider.of<stateApp>(context, listen: false)),
        ),

        //description
        if(widget.note.description!='')
        Padding(
          padding: EdgeInsets.symmetric(vertical : calculateSize(context,18.0), horizontal: calculateSize(context,8.0)),
          child: AutoSizeText(widget.note.description ?? S.of(context).template, style: Theme.of(context).textTheme.bodyMedium,),
        ),
      ],
    );
  }
}
