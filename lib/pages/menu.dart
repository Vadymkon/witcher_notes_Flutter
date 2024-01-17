//import 'dart:html';

//import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:witcher_notes/ads.dart';
import 'package:witcher_notes/noti.dart';
import 'package:witcher_notes/pages/dialogs/add_users.dart';
import 'package:witcher_notes/widgets/elev_button_wrapper.dart';
import 'package:witcher_notes/widgets/exp_list_w.dart';
import 'package:witcher_notes/widgets/trapezoid.dart';
import '../db/notes_database.dart';
import '../db/subnotes_database.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../model/note.dart';
import '../model/subnote.dart';
import '../widgets/checkbox.dart';
import '../widgets/checkstring.dart';
import '../widgets/description.dart';
import '../widgets/exp_tile_w.dart';
import '../widgets/failedDoneButtons.dart';
import '../widgets/message_alert.dart';
import '../widgets/shield.dart';
import '../widgets/shieldLevel.dart';
import '../widgets/task_list.dart';
import '../widgets/task_widget.dart';
import 'dialogs/change_currency.dart';
import 'dialogs/settings.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Map <String,String> listTitles =
{
  'Main Quests':'main'      ,
  'Secondary Quests':'secondary' ,
  'Witcher Contracts':'witcher'   ,
  'Treasure Hunts':'treasure'  ,
  'Completed':  'empty'   ,
  'Failed':  'empty'
};

class Menu extends StatefulWidget {
  // const Menu({Key? key}) : super(key: key);
  @override
  _MenuState createState() => _MenuState();
  }

  class _MenuState extends State<Menu> {
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _bannerIsLoaded = false;

  int rewardedScore = 0;
    // late List<Note>    notes   = Provider.of<stateApp>(context).notes;
    // late List<SubNote> subnotes = Provider.of<stateApp>(context).subnotes;
    // bool isLoading = Prov;

    @override
    void initState() {
      super.initState();
      _bannerIsLoaded = false;
      _createBannerAd();
      _createInterstitialAd();
      _createRewardedAd();
      refreshNotes();

    }

  void _createBannerAd() {
      setState(() {
        _banner = BannerAd(
          size: AdSize.fullBanner,
          adUnitId: AdMobService.bannerAdUnitId!,
          listener: AdMobService.bannerAdListener,
          request: const AdRequest(),)..load();

      });
      _bannerIsLoaded = true;
  }
  void _createInterstitialAd() {
      InterstitialAd.load(
          adUnitId: AdMobService.interstitialAdUnitId!,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (ad) => _interstitialAd = ad,
              onAdFailedToLoad: (LoadAdError error) => _interstitialAd= null));
    }


  void _showInterstitialAd() {
  if (_interstitialAd != null) {
     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
       onAdDismissedFullScreenContent: (ad) {ad.dispose(); _createInterstitialAd(); },
       onAdFailedToShowFullScreenContent: (ad,error) {ad.dispose(); _createInterstitialAd();},
     );
     _interstitialAd!.show();
     _interstitialAd = null;
  }
    }

  void _createRewardedAd() {
      RewardedAd.load(
          adUnitId: AdMobService.rewardedAdUnitId!,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
              onAdLoaded: (ad) => setState(() => _rewardedAd = ad),
              onAdFailedToLoad: (error) => setState(() => _rewardedAd = null),));
  }
  void _showRewardedAd () {
      if (_rewardedAd != null) {
        _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _createRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (ad,error) {
            ad.dispose();
            _createRewardedAd();
        }
        );
        _rewardedAd!.show(
            onUserEarnedReward: (ad,reward) => setState(() => rewardedScore++));
        _rewardedAd = null;
      }
  }

    @override
    void dispose() {
      NotesDatabase.instance.close();
      SubNotesDatabase.instance.close();

      super.dispose();
    }
    Future<void> refreshNotes() async {
      await Provider.of<stateApp>(context, listen: false).refreshNotes();
    }
    /*
    Future refreshNotes() async {
      setState(() => Provider.of<stateApp>(context).isLoading = true);

      Provider.of<stateApp>(context,listen: false).notes = await NotesDatabase.instance.readAllNotes();
      Provider.of<stateApp>(context,listen: false).subnotes = await SubNotesDatabase.instance.readAllNotes();

      Provider.of<stateApp>(context,listen: false).refreshNotes();
      setState(() => Provider.of<stateApp>(context).isLoading = false);
    }

     */

  @override
  Widget build(BuildContext context) {
    Provider.of<stateApp>(context,listen: false).loadFromHistory();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(calculateSize(context, 60.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical : calculateSize(context, 8)),
            child: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).quests.toString().toUpperCase()),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
              actions: [
                IconButton(onPressed: () {openSettings(context);}, icon: Icon(Icons.settings, color: Theme.of(context).primaryColor,))
              ],
            ),
          ),
        ),
        body:
        Stack(
          children: <Widget>
          [
            Positioned(
                bottom: calculateSize(context,-280),
                left: calculateSize(context,120),
                child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/background.png'))
            ),

            SingleChildScrollView(
              child: Column(
              children: [
                // ExpList(),
                if (Provider.of<stateApp>(context).notes != null && Provider.of<stateApp>(context).subnotes != null) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listTitles.length,
                  itemBuilder: (context, index) {
                    return// Container();
                      ExpList(name: listTitles.keys.toList()[index],type: listTitles.values.toList()[index], );
                    // ,notes: Provider.of<stateApp>(context).notes ?? [],subnotes: Provider.of<stateApp>(context).subnotes?? [],);
                  },
                ),

                  // ADVERSTING - not worked
                  // ElevatedButton(onPressed: _showInterstitialAd, child: const Text('Inter Adv')),
                  // TextButton(onPressed: _showRewardedAd, child: Text('Rewarded score = $rewardedScore')),
                  // if (_banner == null && _bannerIsLoaded) Container() else
                  //   Container(
                  //     margin: EdgeInsets.all(calculateSize(context, 56)),
                  //     height: calculateSize(context, 52),
                  //     child: AdWidget(ad:_banner!),
                  //   ),
               ],

                Container(
                  padding: EdgeInsets.all( calculateSize(context,12)),
                  child: Center(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [ Padding(
                        padding: EdgeInsets.only(top: calculateSize(context,188), bottom: calculateSize(context,34)),
                        child: Column(
                          children: [
                            InkWell(
                                child: AutoSizeText(maxLines: 1,"witcher_notes",  style: Theme.of(context).textTheme.labelLarge),
                                onTap: (){
                                  // NotificationService().showNotification(id:23,title: 'asd',body: 'agsasg');
                                  //showImageWithSound(context, S.of(context).discr, 3);
                                  //open_ChangeCurrency(context);
                                }),
                            AutoSizeText(maxLines: 1,S.of(context).discr,  style: Theme.of(context).textTheme.labelSmall),

                          ],
                        ),
                      ),
                      ],),
                  ),),
              ],
          ),
            ),
            Container(height: MediaQuery.of(context).size.height,),

          ]
        ),
    );
  }



}
