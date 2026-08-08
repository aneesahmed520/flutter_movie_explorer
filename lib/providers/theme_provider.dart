import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// ===============================================================
/// Theme Provider
/// ===============================================================
///
/// Handles:
///
/// • Dark mode
/// • Light mode
/// • Theme persistence
///
/// ===============================================================


class ThemeProvider extends ChangeNotifier {


  static const String _themeKey =
      'is_dark_mode';



  bool _isDarkMode = false;



  bool get isDarkMode =>
      _isDarkMode;



  ThemeMode get themeMode =>
      _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light;



  //==============================================================
  // Load Theme
  //==============================================================


  Future<void> loadTheme() async {


    final prefs =
    await SharedPreferences.getInstance();



    _isDarkMode =
        prefs.getBool(
          _themeKey,
        ) ??
            false;



    notifyListeners();


  }





  //==============================================================
  // Toggle Theme
  //==============================================================


  Future<void> toggleTheme() async {


    _isDarkMode =
    !_isDarkMode;



    final prefs =
    await SharedPreferences.getInstance();



    await prefs.setBool(
        _themeKey,
        _isDarkMode
    );



    notifyListeners();


  }





  //==============================================================
  // Set Theme
  //==============================================================


  Future<void> setTheme(
      bool value,
      ) async {


    _isDarkMode =
        value;



    final prefs =
    await SharedPreferences.getInstance();



    await prefs.setBool(
        _themeKey,
        value
    );



    notifyListeners();


  }


}