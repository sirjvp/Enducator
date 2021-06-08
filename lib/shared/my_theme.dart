part of 'shared.dart';

class MyTheme{
  static ThemeData lightTheme(){
    var themeData = ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Color(0xFF1D1E4E),
      primaryColor: Color(0xFFFCCF14),
      accentColor: Color(0xFF2F3180),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      // fontFamily: GoogleFonts.lato().fontFamily,
    );
    return themeData;
  }

  static ThemeData darkTheme(){
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: Color(0x262626),
      scaffoldBackgroundColor: Color(0xFF262626),
      primaryColor: Colors.deepOrange[400],
      accentColor: Colors.deepOrange[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }
}