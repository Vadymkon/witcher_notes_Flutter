import 'package:flutter/material.dart';
import '../extenstion.dart';
import 'checkbox.dart';


//обёртка над стейтлесвиджетом и возврат кнопки
class borderWitcher extends StatefulWidget {
  final double? sizeChanger;
  final Widget? child;
  //final ButtonStyle? style;

  borderWitcher({
    Key? key, this.sizeChanger,
    this.child,
    //this.style,
  }) : super(key: key);

  @override
  State<borderWitcher> createState() => _borderWitcherState();
}

class _borderWitcherState extends State<borderWitcher>
{
  double multi = 0.75;
  bool isTapped = false;
  Widget somethink = Container();
  @override
  Widget build(BuildContext context) {
    if (widget.sizeChanger != null) multi = widget.sizeChanger!;
    if (widget.child != null) somethink = widget.child!;
    return InkWell(
      onTap:() {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(calculateSize(context, 5*multi)),
            child: Container(
              padding: EdgeInsets.all(calculateSize(context, 10*multi)),
              // width: calculateSize(context, 100*multi),
              // height: calculateSize(context, 100*multi),
              color: Theme.of(context).canvasColor,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: calculateSize(context, 10*multi)),
                  // width: calculateSize(context, 80*multi),
                  // height: calculateSize(context, 80*multi),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: somethink,
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: buildPositionedContainer(context, sizeChanger: multi,),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: buildPositionedContainer(context, sizeChanger: multi,),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: buildPositionedContainer(context, sizeChanger: multi,),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildPositionedContainer(context, sizeChanger: multi,),
          ),
        ],
      ),
    );
  }
}