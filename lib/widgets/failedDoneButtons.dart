import 'package:flutter/material.dart';
import 'package:witcher_notes/widgets/trapezoid.dart';
import '../db/notes_database.dart';
import '../extenstion.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../main.dart';
import '../model/note.dart';
import 'message_alert.dart';


//обёртка над стейтлесвиджетом и возврат кнопки
class FDButtons extends StatefulWidget {
  final Note note;
  final stateApp stateAppInstance;
  //final ButtonStyle? style;

  FDButtons({
    Key? key, required this.note, required this.stateAppInstance,
    //this.style,
  }) : super(key: key);

  @override
  State<FDButtons> createState() => _FDButtonsState();
}

class _FDButtonsState extends State<FDButtons>
{
  double multi = 1;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Stack(
        children: [
          Positioned(
            child: InkWell(
              onTap: () async {
                print('object');
                final note = widget.note!.copy(
                    done: true,
                    directory: 'Failed'
                );
                await NotesDatabase.instance.update(note);
                await widget.stateAppInstance.refreshNotes();
                  showImageWithSound(context, note.title, 1);
              },
              splashColor: Colors.red,
              highlightColor: Colors.red,
              child: TapButton(context,color: 'red',),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: () async{
                final note = widget.note!.copy(
                    done: true,
                    directory: 'Completed',
                );
                await NotesDatabase.instance.update(note);
                await widget.stateAppInstance.refreshNotes();
                  showImageWithSound(context, note.title, 2);
              },
              splashColor: Colors.red,
              highlightColor: Colors.red,
              child: TapButton(context,color: 'green',),
            ),///
          ),
          ///
        ],
      ),
    );
  }
}

class TapButton extends StatelessWidget {
  final String color;
  final void Function()? onTap;
  //final ButtonStyle? style;

  TapButton(BuildContext context, {
    Key? key, required this.color, this.onTap,
    //this.style,
  }) : super(key: key);

  @override
  Widget build (BuildContext context)
  {

    return Transform.scale(
      scaleY: color == 'green'? -1: 1,
      child: ClipPath(
        clipper: ClipTrapezoid(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/${color}text.png'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints(maxWidth: calculateSize(context, 220),maxHeight: calculateSize(context, 55)),
          child : Stack(
            children: [

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.black87],
                          stops: [calculateSize(context, 0.67),1],
                        ).createShader(bounds);
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Colors.white, Theme.of(context).primaryColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [calculateSize(context, 0.6),1],
                          ).createShader(bounds);
                        },
                        child: Container(
                          constraints: BoxConstraints(maxWidth: calculateSize(context, 90),maxHeight: calculateSize(context, 15)),
                          child: Transform.scale(
                            scaleY: color == 'green'? -1: 1,
                            child: AutoSizeText(
                              S.of(context).task,
                              style: Theme.of(context).textTheme.titleMedium,maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.black87],
                          stops: [calculateSize(context, 0.67),1],
                        ).createShader(bounds);
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Colors.white, Theme.of(context).primaryColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [calculateSize(context, 0.6),1],
                          ).createShader(bounds);
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: calculateSize(context, 40)),
                          child: Transform.scale(
                            scaleY: color == 'green'? -1: 1,
                            child: AutoSizeText(
                              color == 'green'?S.of(context).done:S.of(context).failed,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}