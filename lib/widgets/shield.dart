import 'package:flutter/material.dart';
import 'package:witcher_notes/pages/dialogs/changename.dart';
import '../extenstion.dart';

class Shield extends StatefulWidget {
  final double? width;
  final double? height;
   final String imageName;
  final void Function()? onTap;

  final void Function(String) onChangedCallback;

  Shield({
    Key? key,
    this.width,
    this.height,
    this.imageName = 'greentext',
    this.onTap,
    required this.onChangedCallback,
  }) : super(key: key);

  @override
  State<Shield> createState() => _ShieldState();
}
class _ShieldState extends State<Shield>
{
  double multi = 1;
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final String? shStr = await changename(context, '');
        if (shStr != null) {
          setState(() {
            // widget.imageName = shStr;
            widget.onChangedCallback(shStr);
          });
        }
      },
      child: Container(
        child: Stack(
          children: <Widget>[

            Positioned(
              left: calculateSize(context,7),
              child: Padding(
                padding: EdgeInsets.all(calculateSize(context,8.0)),
                child: Transform.scale(
                  scale: calculateSize(context,1.15),
                  child: Container(
                    width: widget.width ?? calculateSize(context,220),
                    height: widget.height ?? calculateSize(context,150),
                    child: ClipPath(
                      clipper: ShieldClipper(),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                          width: widget.width ?? calculateSize(context,200),
                          height: widget.height ?? calculateSize(context,150),
                      //    child: Image.asset('assets/${widget.imageName}.png')
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: calculateSize(context,5.5),
              child: Padding(
                padding: EdgeInsets.all(calculateSize(context,8.0)),
                child: Transform.scale(
                  scale: calculateSize(context,1.1),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return SweepGradient(
                          colors: [Colors.brown,Colors.white],
                          center: Alignment.center
                      ).createShader(bounds);
                    },
                    child:  Container(
                      width: widget.width ?? calculateSize(context,220),
                      height: widget.height ?? calculateSize(context,150),
                      child: ClipPath(
                      clipper: ShieldClipper(),
                      child: Container(
                          width: widget.width ?? calculateSize(context,200),
                          height: widget.height ?? calculateSize(context,150),
                          child: Image.asset('assets/shieldtexture.png')),
                    ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(calculateSize(context,8.0)),
              child: Container(
                width: widget.width ?? calculateSize(context,220),
                height: widget.height ?? calculateSize(context,150),
                child: ClipPath(
                clipper: ShieldClipper(),
                child: Container(
                    width: widget.width ?? calculateSize(context,200),
                    height: widget.height ?? calculateSize(context,150),
                    child: Image.asset('assets/${widget.imageName}.png')),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ShieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width / 1.85;
    final h = size.height/1.1;

    path.moveTo(w * 0.1, h * 0.05);
    path.lineTo(w * 0.9, h * 0.05);
    path.lineTo(w, h * 0.05);
    path.lineTo(w, h * 0.3);
    path.cubicTo(w, h * 0.7, w * 0.5, h, w * 0.5, h);
    path.cubicTo(w * 0.5, h, 0, h * 0.7, 0, h * 0.3);
    path.lineTo(0, h * 0.15);
    path.lineTo(w * 0.01, h * 0.05);

    return path;
  }



  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

/*

    path.moveTo(w / 2, h * 0.1);
    path.cubicTo(w * 0.75, h * 0.05, w, h * 0.3, w, h * 0.4);
    path.cubicTo(w, h * 0.6, w * 0.5, h, w * 0.5, h);
    path.cubicTo(w * 0.5, h, 0, h * 0.6, 0, h * 0.4);
    path.cubicTo(0, h * 0.3, w * 0.25, h * 0.05, w / 2, h * 0.1);


            Positioned(
              left: 5,
              child: Transform.scale(
                scale: 1.1,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return SweepGradient(
                      colors: [Colors.brown,Colors.white70],
                  center: Alignment.center
                  ).createShader(bounds);;
                },
                child: ClipPath(
                  clipper: ShieldClipper(),
                  child: Container(
                      width: widget.width ?? 200,
                      height: widget.height ?? 150,
                      child: Image.asset('assets/shieldtexture.png',scale: 2,)),
                ),
              ),
          ),
            ),



 */