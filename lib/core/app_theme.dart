import 'package:flutter/material.dart';

/// ===============================================================
/// App Theme
/// ===============================================================
///
/// Contains:
/// • Light Theme
/// • Dark Theme
/// • Material 3 configuration
///
/// ===============================================================

class AppTheme {


  //==============================================================
  // Light Theme
  //==============================================================

  static ThemeData get lightTheme {

    return ThemeData(

      useMaterial3: true,

      brightness: Brightness.light,

      colorSchemeSeed: Colors.blue,

      scaffoldBackgroundColor:
      Colors.grey.shade100,


      appBarTheme: const AppBarTheme(

        centerTitle: true,

        elevation: 0,

      ),


      cardTheme: CardThemeData(

        elevation: 2,

        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(

          borderRadius:
          BorderRadius.all(
            Radius.circular(16),
          ),

        ),

      ),


      inputDecorationTheme:
      const InputDecorationTheme(

        border: OutlineInputBorder(),

      ),

    );

  }



  //==============================================================
  // Dark Theme
  //==============================================================

  static ThemeData get darkTheme {

    return ThemeData(

      useMaterial3: true,

      brightness: Brightness.dark,

      colorSchemeSeed: Colors.blue,


      appBarTheme: const AppBarTheme(

        centerTitle: true,

        elevation: 0,

      ),


      cardTheme: const CardThemeData(

        elevation: 2,

        margin: EdgeInsets.zero,

      ),


      inputDecorationTheme:
      const InputDecorationTheme(

        border: OutlineInputBorder(),

      ),

    );

  }

}