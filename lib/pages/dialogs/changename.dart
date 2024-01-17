import 'package:flutter/material.dart';
import 'package:witcher_notes/widgets/textfieldwrapper.dart';
import '../../extenstion.dart';
import 'package:witcher_notes/generated/l10n.dart';

import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:auto_size_text/auto_size_text.dart';
import '../../widgets/elev_button_wrapper.dart';

Future<String?> changename(BuildContext context,String name , {String outText = ''}) async {
  TextEditingController controller = TextEditingController(text: name);
  String? newName = await showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 30.0))),
      ),
      shadowColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.all(calculateSize(context, 18.0)),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 50.0))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(calculateSize(context, 8.0)),
                child: AutoSizeText(
                  maxLines: 1,
                  S.of(context).meow_message,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: calculateSize(context, 8.0), vertical: calculateSize(context, 4.0)),
                child: Opacity(
                  opacity: 0.8,
                  child: AutoSizeText(
                    maxLines: 1,
                    S.of(context).meow_message,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(calculateSize(context, 8.0)),
                child: TextFieldWrapper(
                  sometext: outText,
                  hint: S.of(context).meow_message,
                  type: TextFieldType.text,
                  controller: controller,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  ElevButtonWrapper(
                    onPressed: () {
                      Navigator.pop(context, controller.text);
                    },
                    child: Icon(Icons.navigate_next, size: calculateSize(context, 40)),
                    customcolor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return newName;
}