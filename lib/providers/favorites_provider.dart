import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';



/// ===============================================================
/// Favorites Provider
/// ===============================================================
///
/// Handles:
///
/// • Add favorite movies
/// • Remove favorite movies
/// • Toggle favorite
/// • Check favorite status
/// • Save favorites locally
///
/// Storage:
/// SharedPreferences
///
/// ===============================================================


class FavoritesProvider extends ChangeNotifier {



  static const String _key =
      'favorite_movies';




  //--------------------------------------------------------------
  // Favorites List
  //--------------------------------------------------------------


  final List<Movie> _favorites = [];



  List<Movie> get favorites =>
      List.unmodifiable(
          _favorites
      );



  bool get hasFavorites =>
      _favorites.isNotEmpty;

  int get favoritesCount =>
      _favorites.length;



  //--------------------------------------------------------------
  // Initialize Favorites
  //--------------------------------------------------------------


  Future<void> initializeFavorites() async {


    final prefs =
    await SharedPreferences.getInstance();



    final savedMovies =
    prefs.getStringList(
      _key,
    );



    if(savedMovies == null){

      return;

    }




    _favorites
      ..clear()
      ..addAll(

        savedMovies.map(

              (movie) => Movie.fromJson(

            jsonDecode(movie),

          ),

        ),

      );



    notifyListeners();


  }







  //--------------------------------------------------------------
  // Add Favorite
  //--------------------------------------------------------------


  Future<void> addFavorite(

      Movie movie,

      ) async {



    if(isFavorite(movie.id)){


      return;


    }





    _favorites.add(

      movie,

    );





    await _saveFavorites();





    notifyListeners();


  }







  //--------------------------------------------------------------
  // Remove Favorite
  //--------------------------------------------------------------


  Future<void> removeFavorite(

      Movie movie,

      ) async {



    _favorites.removeWhere(

          (item) =>

      item.id == movie.id,

    );





    await _saveFavorites();





    notifyListeners();


  }







  //--------------------------------------------------------------
  // Toggle Favorite
  //--------------------------------------------------------------


  Future<void> toggleFavorite(

      Movie movie,

      ) async {



    if(isFavorite(movie.id)){



      await removeFavorite(

          movie

      );


    }

    else {



      await addFavorite(

          movie

      );


    }



  }







  //--------------------------------------------------------------
  // Check Favorite
  //--------------------------------------------------------------


  bool isFavorite(

      int movieId,

      ){



    return _favorites.any(

          (movie) =>

      movie.id == movieId,

    );


  }







  //--------------------------------------------------------------
  // Clear All Favorites
  //--------------------------------------------------------------


  Future<void> clearFavorites() async {



    _favorites.clear();



    await _saveFavorites();



    notifyListeners();


  }







  //--------------------------------------------------------------
  // Save Favorites
  //--------------------------------------------------------------


  Future<void> _saveFavorites() async {



    final prefs =

    await SharedPreferences.getInstance();





    final data =

    _favorites.map(

          (movie) =>

          jsonEncode(

            movie.toJson(),

          ),

    )

        .toList();





    await prefs.setStringList(

      _key,

      data,

    );



  }




}