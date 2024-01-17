import 'package:flutter/material.dart';
import '../extenstion.dart';
import 'checkbox.dart';


//обёртка над стейтлесвиджетом и возврат кнопки
class borderWitcher2 extends StatefulWidget {
  final double? sizeChanger;
  final Widget? child;
  //final ButtonStyle? style;

  borderWitcher2({
    Key? key, this.sizeChanger,
    this.child,
    //this.style,
  }) : super(key: key);

  @override
  State<borderWitcher2> createState() => _borderWitcher2State();
}

class _borderWitcher2State extends State<borderWitcher2>
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
              padding: EdgeInsets.all(calculateSize(context, 3*multi)),
              color: Theme.of(context).canvasColor,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: calculateSize(context, 10*multi)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.all(calculateSize(context, 4.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(calculateSize(context, 5*multi)),
                      child: Container(
                        color: Theme.of(context).canvasColor,
                        child: Center(
                          child: Container(
                            // padding: EdgeInsets.symmetric(horizontal: calculateSize(context, 10*multi)),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: somethink,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            top: 0,
            left: 0,
            child: buildPositionedContainer2(context, sizeChanger: multi*0.4,),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: buildPositionedContainer2(context, sizeChanger: multi*0.4,),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: buildPositionedContainer2(context, sizeChanger: multi*0.4,),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildPositionedContainer2(context, sizeChanger: multi*0.4,),
          ),
        ],
      ),
    );
  }
}

class buildPositionedContainer2 extends StatelessWidget {
  final double? sizeChanger;
  //final ButtonStyle? style;

  buildPositionedContainer2(BuildContext context, {
    Key? key, this.sizeChanger,
    //this.style,
  }) : super(key: key);

  @override
  Widget build (BuildContext context)
  {
    double? multi = sizeChanger == null?1:sizeChanger;
    return ClipRRect(
      borderRadius: BorderRadius.circular(calculateSize(context, 5*multi!)),
      child: Container(
        width: calculateSize(context, 28*multi!),
        height: calculateSize(context, 37*multi!),
        color: Theme.of(context).canvasColor,
        child: Center(
          child: Container(
            width: calculateSize(context, 20*multi!),
            height: calculateSize(context, 30*multi!),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}