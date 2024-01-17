import 'package:flutter/material.dart';


import 'package:auto_size_text/auto_size_text.dart';

import '../../extenstion.dart';
import '../../generated/l10n.dart';
import '../../widgets/border_witcher.dart';
import '../../widgets/border_witcher_2.dart';


void secret(BuildContext context) {

  // import 'package:provider/provider.dart';
  // Provider.of<stateApp>(context, listen: false)

  //TextEditingController textEditingController = TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 22.0))),
        ),
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.27),//Colors.red,
        child: Padding(
            padding: EdgeInsets.all(calculateSize(context,18.0)),
            child: Container(
              constraints: BoxConstraints(maxWidth: calculateSize(context,260.0),
                  // maxHeight: calculateSize(context, 400)
              ),
              // height: 230.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius:
                new BorderRadius.all(new Radius.circular(calculateSize(context,50.0))),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(S.of(context).thanks,style: Theme.of(context).textTheme.labelMedium,),
                  Center(
                    child: borderWitcher2(child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset('assets/secret_photo.png'),
                    )),
                  ),
                  AutoSizeText(S.of(context).vk,style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),))
    ),

  );
}