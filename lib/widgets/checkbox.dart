import 'package:flutter/material.dart';
import '../extenstion.dart';


//обёртка над стейтлесвиджетом и возврат кнопки
class CheckWitcherBox extends StatefulWidget {
  final double? sizeChanger;
  final bool? isTapped;
  final Function(bool)? onTapCallback;
  //final ButtonStyle? style;

  CheckWitcherBox({
    Key? key, this.sizeChanger, this.isTapped, this.onTapCallback
    // this.Somethink,
    //this.style,
  }) : super(key: key);

  @override
  State<CheckWitcherBox> createState() => _CheckWitcherBoxState();
}

class _CheckWitcherBoxState extends State<CheckWitcherBox>
{
  double multi = 1;
  bool isTapped = false;
  Widget somethink = Container();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isTapped != null)
    isTapped = widget.isTapped!;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sizeChanger != null) multi = widget.sizeChanger!;
     // isTapped = widget.isTapped!;
    // if (widget.Somethink != null) somethink = widget.Somethink!;
    return InkWell(
      onTap:() {
        setState(() {

          isTapped = !isTapped;
          widget.onTapCallback!(isTapped);
        });
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(calculateSize(context, 5*multi)),
            child: Container(
              width: calculateSize(context, 100*multi),
              height: calculateSize(context, 100*multi),
              color: Theme.of(context).canvasColor,
              child: Center(
                child: Container(
                  width: calculateSize(context, 80*multi),
                  height: calculateSize(context, 80*multi),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),

          // somethink,
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

          Opacity(
            opacity: isTapped ? 1 : 0,
            child: Container(
              width: calculateSize(context, 100 * multi),
              height: calculateSize(context, 100 * multi),
              child: Image.asset('assets/choosecircle.png'),
            ),),
        ],
      ),
    );
  }
}

class buildPositionedContainer extends StatelessWidget {
  final double? sizeChanger;
  //final ButtonStyle? style;

  buildPositionedContainer(BuildContext context, {
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
        width: calculateSize(context, 25*multi!),
        height: calculateSize(context, 25*multi!),
        color: Theme.of(context).canvasColor,
        child: Center(
          child: Container(
            width: calculateSize(context, 20*multi!),
            height: calculateSize(context, 20*multi!),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}