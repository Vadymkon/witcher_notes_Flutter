import 'package:flutter/material.dart';
import 'package:witcher_notes/extenstion.dart';
import 'package:witcher_notes/widgets/texttypes.dart';

//dark
Color _darky = Color(0xFF0a0a0a);
Color _texty = Color(0xFFdadada);
Color _textyChoosen = Color(0xFF827669);
Color _textydescription = Color(0xFF868581);

Color _textyLeftChoosen = Color(0xFFc6c0b4);
Color _textyLeftUnchoosen = Color(0xFF817f7c);
Color _textyLeftdesc = Color(0xFF6d6c6a);
Color _textyLeftNumbers = Color(0xFFb4b0ad);

Color _scrollbar = Color(0xFF4f3d33);
Color _gradient = Color(0xFF1d1b03);
Color _box = Color(0xFF212121);
Color _tasklistUnchoosed = Color(0xFF0f0c0d);


Color _doneDark = Color(0xFF2d502f);
Color _circle = Color(0xFFbe9856);
Color _sign = Color(0xFFdbc55c);




Color _skiny = Color(0xFFdea16b);
// Color _peorply = Color(0xFF9a93fd);
// Color _bluey = Color(0xFF45578f);

final kDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: _darky,
  primaryColor: _texty,
  cardColor: Colors.transparent,
  // shadowColor: _peorply,

  canvasColor:  _box,
  secondaryHeaderColor: _textyChoosen,
  unselectedWidgetColor: _textydescription,
  dialogBackgroundColor: _darky,

  dividerColor: _tasklistUnchoosed,

  appBarTheme: AppBarTheme(
    color: _darky
  ),
  textTheme: TextTheme(
    labelLarge: headerOne.copyWith(color: _texty),
    labelMedium: headerTwo.copyWith(color: _texty),
    labelSmall: headerThree.copyWith(color: _skiny),
    bodyLarge: body1.copyWith(color: _texty),
    bodyMedium: body2.copyWith(color: _textydescription),
    // bodySmall: headerFour.copyWith(color: _skiny.withOpacity(0.6)),
      titleSmall: body2.copyWith(color: _textydescription.withOpacity(0.6))
  ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(headerTwo),
             // backgroundColor: MaterialStateProperty.all<Color>(_tasklistUnchoosed),
            // foregroundColor: MaterialStateProperty.all<Color>(_tasklistUnchoosed)
            //MaterialStateProperty.all<Color>(_bluey)
        )),
);


/*
//light

Color _whity = Color(0xFFfaffff);
Color _redy = Color(0xFFe6491b);
Color _greytyDark = Color(0xFF5d5450);
Color _greytyLight = Color(0xFF9b9b9d);



final kLightTheme = ThemeData.dark().copyWith(
  primaryColor: _greytyLight,
  scaffoldBackgroundColor: _whity,
  cardColor: _redy,
  shadowColor: _greytyDark,

  unselectedWidgetColor: _greytyLight,
  dialogBackgroundColor: _whity,

  appBarTheme: AppBarTheme(
      color: _whity
  ),
  textTheme: TextTheme(
      labelLarge: headerOne.copyWith(color: _greytyDark),
      labelMedium: headerTwo.copyWith(color: _greytyDark),
      labelSmall: headerThree.copyWith(color: _redy),
      titleSmall: headerFour.copyWith(color: _redy.withOpacity(0.6))
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(headerTwo),
          backgroundColor: MaterialStateProperty.all<Color>(_greytyDark),
          foregroundColor: MaterialStateProperty.all<Color>(_whity)
        //MaterialStateProperty.all<Color>(_bluey)
      )),
);

 */

/*
final kLightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
        color: Colors.cyanAccent
    )
);
 */