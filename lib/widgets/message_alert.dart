import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:witcher_notes/extenstion.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../main.dart';


Future<void> showImageWithSound(BuildContext context,String text, int questState) async {
  final overlay = Overlay.of(context);
  List q = [S.of(context).q1, S.of(context).q2, S.of(context).q3, S.of(context).q4];
  Color textYellow = Color(0xFFf1d8b3);
  Color textBackY = Color(0xFF48381a);
  Color textGrey = Color(0xFFa19f93);
  Color textBackG = Color(0xFF392b27);
  Color textRed = Color(0xFFf04949);
  Color textBackR = Color(0xFF6e0e02);

  // Function to show text
  Future<void> showText() async {
    /*
QUEST UPDATED!
QUEST FAILED!
QUEST COMPLETED!
RECEIVED:
     */
    double scaleSize = 0.9;
    double bottom = 0.45; //1 -> 0
    Color textFront = questState != 1? textYellow : textRed     ;
    Color textBack  = questState != 1? textBackY  : textBackR   ;
    final controller = AnimationController(
      vsync: Navigator.of(context) as TickerProvider,
      duration: Duration(seconds: 3),
    );
    bool isAnim = false;
    final overlayEntry01 = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
          top: MediaQuery.of(context).size.height * bottom,
          left: 0,
          right: 0,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              if (value == 1) isAnim = true;
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 0.0),
                duration: Duration(seconds: 4),
                builder: (context,value,child) {
                  return Padding(
                    padding: EdgeInsets.only(top: calculateSize(context,250.0)),
                    child: Center(child:
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 23))),
                      child: Container(
                        width:  MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.4,
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(value),
                        // questState == 1 ? : textBackR.withOpacity(0.5),
                        child: child,
                      ),
                    ),),
                  );},
              );
            },
          ),
        ),
         ]
      ),
    );
    final overlayEntry02 = OverlayEntry(
      builder: (context) => Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * bottom,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  if (value == 1) isAnim = true;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.8, end: 0.0),
                    duration: Duration(seconds: 4),
                    builder: (context,value,child) {
                      return Padding(
                        padding: EdgeInsets.only(top: calculateSize(context,250.0)),
                        child: Center(child:
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(calculateSize(context, 23))),
                          child: Container(
                            width:  MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.4,
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(value),
                            // questState == 1 ? : textBackR.withOpacity(0.5),
                            child: child,
                          ),
                        ),),
                      );},
                  );
                },
              ),
            ),
          ]
      ),
    );
    final overlayEntry1 = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
          top: MediaQuery.of(context).size.height * bottom,
          left: 0,
          right: 0,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              if (value == 1) isAnim = true;
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: Duration(seconds: 3),
              builder: (context,value,child) {
                  return Opacity(opacity: value, child: child,);},
              child: Padding(
                padding: EdgeInsets.only(top: calculateSize(context,250.0)),
                child: Center(child: Stack(
                  children: [
                    Transform.scale(
                      // scale: calculateSize(context,1.2),
                      scale: scaleSize,
                      child: Opacity(
                        opacity: 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(q[questState].toUpperCase(),
                                style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: calculateSize(context,25),
                                  color: textBack,
                                )),
                            Text(text.toUpperCase(),
                                style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: calculateSize(context,50),
                                  color: textBack,
                                ), maxLines: 2,),
                          ],),
                      ),
                    ),
                    Transform.scale(
                      // scale: calculateSize(context,1.2),
                      scale: scaleSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q[questState].toUpperCase(),
                            style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: calculateSize(context,25),
                              color: questState != 2? textBack : textBackG,
                            )),
                        Text(text.toUpperCase(),
                            style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: calculateSize(context,50),
                              color: questState != 2? textBack : textBackG,),maxLines: 2,),
                      ],),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
          Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: 0,
          right: 0,
          child:
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Opacity(
                opacity: 1 - controller.value,
                child: child,
              );
            },),
        ),]
      ),
    );
    final overlayEntry2 = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
          top: MediaQuery.of(context).size.height * bottom,
          left: 0,
          right: 0,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              if (value == 1) isAnim = true;
              return Opacity(
                opacity: value,
                child: child,
              );

            },
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: Duration(seconds: 3),
              builder: (context,value,child) {
                  return Opacity(opacity: value, child: child,);},
              child: Padding(
                padding: EdgeInsets.only(top: calculateSize(context,250.0)),
                child: Center(child: Stack(
                  children: [
                    Transform.scale(
                      // scale: calculateSize(context,1.2),
                      scale: scaleSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q[questState].toUpperCase(),
                              style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: calculateSize(context,25),
                                color: textBack,
                              )),
                          Text(text.toUpperCase(),
                              style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: calculateSize(context,50),
                                color: textBack,),maxLines: 2,),
                        ],),
                    ),
                    Transform.scale(
                      // scale: calculateSize(context,1.2),
                      scale: scaleSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(q[questState].toUpperCase(),
                            style:Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontSize: calculateSize(context,25),
                              color: questState != 2? textFront : textGrey,
                            )),
                        Text(text.toUpperCase(),
                            style:Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontSize: calculateSize(context,50),
                              color: questState != 2? textFront : textGrey,),maxLines: 2,),
                      ],),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
          Positioned(
          top: MediaQuery.of(context).size.height * bottom,
          left: 0,
          right: 0,
          child:
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Opacity(
                opacity: 1 - controller.value,
                child: child,
              );
            },),
        ),]
      ),
    );
    //
    // final overlayEntry2 = OverlayEntry(
    //   builder: (context) => Positioned(
    //     top: MediaQuery.of(context).size.height * 0.6,
    //     left: 0,
    //     right: 0,
    //     child: TweenAnimationBuilder<double>(
    //       tween: Tween(begin: 0.0, end: 1.0),
    //       duration: Duration(seconds: 1),
    //       builder: (context, value, child) {
    //         return Opacity(
    //           opacity: value,
    //           child: child,
    //         );
    //       },
    //       child: Center(child: Text('Надпись 2')),
    //     ),
    //   ),
    // );

    overlay.insert(overlayEntry01);
    overlay.insert(overlayEntry02);
    overlay.insert(overlayEntry1);
    overlay.insert(overlayEntry2);
    // Fade out the text gradually
    controller.forward();
    // Wait for 2 seconds
    await Future.delayed(Duration(seconds: 4));



    // Remove text from overlay after 1 second
    overlayEntry01.remove();
    overlayEntry02.remove();
    overlayEntry1.remove();
    overlayEntry2.remove();
  }

  // Function to play sound
  Future<void> playSound() async {
    final player = AudioPlayer();
    String nameSound = 'completed.mp3';
    /*
QUEST UPDATED!
QUEST FAILED!
QUEST COMPLETED!
RECEIVED:
     */
    switch (questState) {
      case 0:
        nameSound = 'update_quest.mp3';
        break;
      case 1:
        nameSound = 'take_quest.mp3';
        break;
      case 2:
        nameSound = 'completed.mp3';
        break;
      case 3:
        nameSound = 'new_quest.mp3';
        break;
    }
    await player.setAsset('assets/$nameSound');

    // Wait for 0.75 seconds before starting the sound
    await Future.delayed(Duration(milliseconds: 0));

    // Start playing sound
    player.play();

    // Wait for 2 seconds
    await Future.delayed(Duration(seconds: 4));

    // Fade out the sound
    player.setVolume(0.0);
  }

  // Start both text and sound simultaneously
  await Future.wait([showText(), playSound()]);
}

class FadeTransitionSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Fade();
}

class _Fade extends State<FadeTransitionSample> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animation.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  FadeTransition build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: Container(
        color: Colors.green,
        width: 100,
        height: 100,
      ),
    );
  }
}
