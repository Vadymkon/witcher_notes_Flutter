import 'package:flutter/material.dart';
import 'package:witcher_notes/pages/dialogs/secret.dart';
import 'package:witcher_notes/widgets/border_witcher.dart';
import 'package:witcher_notes/widgets/checkstring.dart';
import 'package:witcher_notes/widgets/textfieldwrapper.dart';
import '../../extenstion.dart';
import '../../main.dart';
import 'package:witcher_notes/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import '../../widgets/border_witcher_2.dart';
import '../../widgets/dropdown_wrapper.dart';
import '../../widgets/elev_button_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (await canLaunch(_url.toString())) {
    await launch(_url.toString());
  } else {
    throw Exception('Could not launch $_url');
  }
}

void openSettings(BuildContext context) {

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
        child: Stack(
          children: [Padding(
            padding: EdgeInsets.all(calculateSize(context,18.0)),
            child: Container(
              constraints: BoxConstraints(maxWidth: calculateSize(context,260.0)),
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:calculateSize(context,8)),
                      child: AutoSizeText(maxLines: 1,S.of(context).settings,style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.1,
                      child: CheckString(text: S.of(context).plusB,isSub: false,
                          isChecked: Provider.of<stateApp>(context).isPlusButton,
                      onTapCallback: (value){
                          Provider.of<stateApp>(context,listen: false).changePlusB();

                      },)),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:calculateSize(context,8)),
                      child: AutoSizeText(maxLines: 3,S.of(context).tip1,style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                  borderWitcher(
                    child: ElevButtonWrapper(
                      customcolor: Colors.transparent,
                        noPadding: false,
                        onPressed: () async {
                      await _launchUrl('https://play.google.com/store/games?');
                    }, child: AutoSizeText(maxLines: 1,S.of(context).pro)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: borderWitcher(
                      child: ElevButtonWrapper(
                          customcolor: Colors.transparent,
                          noPadding: false,
                          onPressed: () async {
                        await _launchUrl('http://surl.li/iwmvr');
                      }, child: AutoSizeText(maxLines: 1,'    ${S.of(context).donat}    ')),
                    ),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AutoSizeText(maxLines: 1,S.of(context).close,style: Theme.of(context).textTheme.labelSmall),)
                ],
              ),)),
            Positioned(
              left: 0,
              bottom: 0,
              child: TextButton(
                child: AutoSizeText('   '),
                onPressed: () {
                  secret(context);
                },
              ),
            ),
          ]
        )
    ),

  );
}