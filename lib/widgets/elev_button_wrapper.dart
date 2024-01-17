import 'package:flutter/material.dart';

import '../extenstion.dart';

//просто батон-стайл
ButtonStyle buttonOrdinary = ElevatedButton.styleFrom(

  minimumSize: Size(70, 50),
  padding: EdgeInsets.all(20),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
);

//обёртка над стейтлесвиджетом и возврат кнопки
class ElevButtonWrapper extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? customcolor;
  final bool? noPadding;
  //final ButtonStyle? style;

  ElevButtonWrapper({
    Key? key,
    required this.onPressed,
    required this.child,
    this.customcolor,
    this.noPadding,
    //this.style,
  }) : super(key: key);

  bool _noPadding = true;
  @override
  Widget build(BuildContext context) {
    if (noPadding != null) _noPadding = noPadding!;
    //buttonOrdinary = buttonOrdinary.copyWith(style);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: calculateSize(context,8), horizontal: calculateSize(context,5)),
      child: Container(
        decoration:  !_noPadding ? null:BoxDecoration(
            border: Border.all(width:calculateSize(context, 5),color: Theme.of(context).canvasColor.withOpacity(
                calculateSize(context, 0.5)))
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: buttonOrdinary.copyWith(
            minimumSize: MaterialStateProperty.all<Size>(Size(calculateSize(context,70), calculateSize(context,50))),
            padding:  !_noPadding ? MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero) :
            MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(calculateSize(context,15))),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,20))),),
          ),
          /*
          buttonOrdinary.copyWith(
              : buttonOrdinary.copyWith(
            */
          ).copyWith(
          backgroundColor: !_noPadding ? customcolor != null ? MaterialStateProperty.all<Color>(customcolor!): MaterialStateProperty.all<Color>(Theme.of(context).primaryColor.withOpacity(0.05))
              : customcolor != null && customcolor != Theme.of(context).shadowColor ?
            MaterialStateProperty.all<Color>(customcolor!) : MaterialStateProperty.all<Color>(Theme.of(context).shadowColor) ),
          child: child,
        ),
      ),
    );
  }
}
