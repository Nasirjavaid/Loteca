import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypoGraphy {
  static TextStyle errorHintStyle = TextStyle(color: Colors.white70);
}

class AppTheme {
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFAFAFA);
  static const Color background1 = Color(0xFFECECEC);
  static const Color background2 = Color(0xFFFFD3B7);
  static const Color background3 = Color(0xFFFFC19A);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color nearlyGold = Color(0xFFE9AD03);

  static const Color appDefaultColor = Color(0xFFe6732d);
  static const Color appDefaultColor2 = Color(0xFFEC8A4C);
  static const Color appDefaultColorForGradient = Color(0xFFe6732d);
  static const Color appCardColor = Color(0xFFe6732d);
  static const Color appDefaultButtonSplashColor = Colors.white12;

  static const Color nearlyRed = Color(0xFFE59007);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color divideColor = Color(0xFFEEEEEE);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static Color lightRed = Colors.red[300];
  static Color lightBlue = Colors.blue[300];
  static Color lightamber = Colors.amber[300];

  static Color drawerBackgroundColor1 = Color(0xFF367CFE);
  static Color drawerBackgroundColor2 = Color(0xFF1284DD);
  static Color drawerBackgroundColor3 = Color(0xFF02ABFF);

  static Color pieChart1Color1 = Color(0xFFEC6B56);
  static Color pieChart1Color2 = Color(0xFFFFC154);
  static Color pieChart1Color3 = Color(0xFF47B39C);

  static Color pieChart2Color1 = Color(0xFF58508D);
  static Color pieChart2Color2 = Color(0xFFBC5090);
  static Color pieChart2Color3 = Color(0xFFFF6361);

  static Color pieChart3Color1 = Color(0xFF0674C4);
  static Color pieChart3Color2 = Color(0xFFDDDDDD);
  static Color pieChart3Color3 = Color(0xFFA9A9A9);

  static Color pieChartBackgroundColor = Color(0xFFe0f2f1);
  static Color pieChartBackgroundColor1 = Colors.blue[50];
  static Color pieChartBackgroundColor2 = Colors.amber[400];
  static Color pieChartBackgroundColor3 = Colors.red[300];
  static Color pieChartBackgroundColor4 = Color(0xFFe0f5ff);
  static Color pieChartBackgroundColor5 = Color(0xFFdcf2e9);
  static Color pieChartBackgroundColor6 = Color(0xFFf7eded);
  static Color netPayAbleSalary = Color(0xFF870707);
  static Color salarySlipDateColor = Color(0xFF624699);
  static Color salarySlipDateColorBackgrpund = Color(0xFFe4cef5);
  static Color textFieldOfCartBackbgtoundColor = Color(0xFFf5f5f5);

  static List<Color> pieCahrtColourList1 = [pieChart1Color1, pieChart1Color3];
  static List<Color> pieCahrtColourList2 = [
    pieChart2Color1,
    pieChart2Color2,
    pieChart2Color3
  ];
  static List<Color> pieCahrtColourList3 = [
    pieChart3Color1,
    pieChart3Color2,
    pieChart3Color3
  ];

  static Color appBackgroundColor = Colors.white;
  static Color appBackgroundColorforCard1 = Color(0xFF3D404F);
  static Color appBackgroundColorforCard2 = Color(0xFF4873A6);
  static Color appBackgroundColorforCard3 = Color(0xFF5A5387);
  static Color appBackgroundColorforCard4 = Color(0xFF524365);
  static Color appBackgroundColorforloginCard = Colors.blue[300];

  static Color appBackgroundColorforCard5 = Color(0xFF2193b0);

  static Color appBackgroundColorForButtons = Color(0xFF3A4F73);

  static const Color loginGradientStart = const Color(0xFF00c6ff);
  static const Color loginGradientEnd = const Color(0xFF0072ff);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  AppTheme._();

  static Color _iconColor = Colors.blueAccent.shade200;

  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Colors.white;
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  // static const Color _darkPrimaryColor = Colors.white24;
  // static const Color _darkPrimaryVariantColor = Colors.black;
  // static const Color _darkSecondaryColor = Colors.white;
  // static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
      //cursorColor: Colors.blue[500],
     
      accentColor: Colors.orange[100],
      hintColor: Colors.orangeAccent,
      focusColor: Colors.orangeAccent,
      primaryColorLight: Colors.orangeAccent,
      highlightColor: Colors.orange[100],
      scaffoldBackgroundColor: _lightPrimaryVariantColor,
      appBarTheme: AppBarTheme(
        color: _lightPrimaryVariantColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent)),
      ),
      colorScheme: ColorScheme.light(
          primary: _lightPrimaryColor,
          primaryVariant: _lightPrimaryVariantColor,
          secondary: _lightSecondaryColor,
          onPrimary: _lightOnPrimaryColor,
          background: Colors.white),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),

//textTheme: GoogleFonts.robotoTextTheme(lightTextTheme)
      textTheme: lightTextTheme);

  // static final ThemeData darkTheme = ThemeData(
  //   scaffoldBackgroundColor: _darkPrimaryVariantColor,
  //   appBarTheme: AppBarTheme(
  //     color: _darkPrimaryVariantColor,
  //     iconTheme: IconThemeData(color: _darkOnPrimaryColor),
  //   ),
  //   colorScheme: ColorScheme.light(
  //     primary: _darkPrimaryColor,
  //     primaryVariant: _darkPrimaryVariantColor,
  //     secondary: _darkSecondaryColor,
  //     onPrimary: _darkOnPrimaryColor,
  //     background: Colors.black
  //   ),
  //   iconTheme: IconThemeData(
  //     color: _iconColor,
  //   ),
  //   textTheme: _darkTextTheme,
  // );

  static final TextTheme lightTextTheme = TextTheme(
      headline4: _lightScreenTextStyleDisplay1,
      headline3: _lightScreenTextStyleDisplay2,
      headline2: _lightScreenTextStyleDisplay3,
      headline1: _lightScreenTextStyleDisplay4,
      headline5: _lightScreenTextStyleHeadline,
      headline6: _lightScreenTextStyleTitle,
      subtitle1: _lightScreenTextStyleSubhead,
      bodyText2: _lightScreenTextStyleBody2,
      bodyText1: _lightScreenTextStyleBody1,
      caption: _lightScreenTextStyleCaption,
      button: _lightScreenTextStyleButton,
      subtitle2: _lightScreenTextStyleSubTitle,
      overline: _lightScreenTextStyleSubOverLine);

  // static final TextTheme _darkTextTheme = TextTheme(
  //    display1: _darkScreenTextStyleDisplay1,
  //   display2: _darkScreenTextStyleDisplay2,
  //   display3: _darkScreenTextStyleDisplay3,
  //   display4: _darkScreenTextStyleDisplay4,
  //   headline: _darkScreenTextStyleHeadline,
  //   title: _darkScreenTextStyleTitle,
  //   subhead: _darkScreenTextStyleSubhead,
  //   body2: _darkScreenTextStyleBody2,
  //   body1: _darkScreenTextStyleBody1,
  //   caption: _darkScreenTextStyleCaption,
  //   button: _darkScreenTextStyleButton,
  //   subtitle: _darkScreenTextStyleSubTitle,
  //   overline: _darkScreenTextStyleSubOverLine

  // );

  /// Suggested  BY Material design
  /// NAME       SIZE   WEIGHT   SPACING  2018 NAME
  /// display4   112.0  thin     0.0      headline1
  /// display3   56.0   normal   0.0      headline2
  /// display2   45.0   normal   0.0      headline3
  /// display1   34.0   normal   0.0      headline4
  /// headline   24.0   normal   0.0      headline5
  /// title      20.0   medium   0.0      headline6
  /// subhead    16.0   normal   0.0      subtitle1
  /// body2      14.0   medium   0.0      body1
  /// body1      14.0   normal   0.0      body2
  /// caption    12.0   normal   0.0      caption
  /// button     14.0   medium   0.0      button
  /// subtitle   14.0   medium   0.0      subtitle2
  /// overline   10.0   normal   0.0      overline
  ///
  ///
  ///
  ///
  /// For light theme
  /// by writer
  /// static final TextStyle _lightScreenHeadingTextStyle = TextStyle(fontSize: 48.0, color: _lightOnPrimaryColor);
  /// static final TextStyle _lightScreenTaskNameTextStyle = TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
  /// static final TextStyle _lightScreenTaskDurationTextStyle = TextStyle(fontSize: 16.0, color: Colors.grey);

//By me
  static final TextStyle _lightScreenTextStyleDisplay1 = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 34.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleDisplay2 = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 45.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleDisplay3 = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 56.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleDisplay4 = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 112.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleHeadline = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 24.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleTitle = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleSubhead = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 16.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleBody1 = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 11.0, color: Colors.black54));
  static final TextStyle _lightScreenTextStyleBody2 = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleCaption = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 12.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleButton = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleSubTitle = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor));
  static final TextStyle _lightScreenTextStyleSubOverLine = GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 10.0, color: _lightOnPrimaryColor));
//

  /// For dark theme
//by writer
  // static final TextStyle _darkScreenHeadingTextStyle = _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  // static final TextStyle _darkScreenTaskNameTextStyle = _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  // static final TextStyle _darkScreenTaskDurationTextStyle = _lightScreenTaskDurationTextStyle;

  //By me
//  static final TextStyle _darkScreenTextStyleDisplay1  = TextStyle(fontSize: 34.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleDisplay2  = TextStyle(fontSize: 45.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleDisplay3  = TextStyle(fontSize: 56.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleDisplay4  = TextStyle(fontSize: 112.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleHeadline  = TextStyle(fontSize: 24.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleTitle  = TextStyle(fontSize: 20.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleSubhead  = TextStyle(fontSize: 16.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleBody1  = TextStyle(fontSize: 11.0, color:Colors.white70);
//  static final TextStyle _darkScreenTextStyleBody2  = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleCaption  = TextStyle(fontSize: 12.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleButton  = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleSubTitle  = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
//  static final TextStyle _darkScreenTextStyleSubOverLine  = TextStyle(fontSize: 10.0, color: _darkOnPrimaryColor);
//
}
