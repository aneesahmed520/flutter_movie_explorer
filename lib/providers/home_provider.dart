import 'package:flutter/foundation.dart';

import '../core/exceptions.dart';
import '../core/view_state.dart';

import '../models/movie.dart';

import '../repositories/i_movie_repository.dart';



class HomeProvider extends ChangeNotifier {


  final IMovieRepository _repository;



  HomeProvider({

    required this._repository,

  });







  //==============================================================
  // State
  //==============================================================


  ViewState _state =
      ViewState.idle;


  ViewState get state =>
      _state;



  String? _errorMessage;


  String? get errorMessage =>
      _errorMessage;




  //==============================================================
  // Movies
  //==============================================================


  List<Movie> _trendingMovies = [];


  List<Movie> get trendingMovies =>
      List.unmodifiable(
          _trendingMovies
      );




  List<Movie> _popularMovies = [];


  List<Movie> get popularMovies =>
      List.unmodifiable(
          _popularMovies
      );





  //==============================================================
  // Pagination
  //==============================================================


  int _popularPage = 1;


  bool _isLoadingMore = false;


  bool get isLoadingMore =>
      _isLoadingMore;





  //==============================================================
  // Load Home Movies
  //==============================================================


  Future<void> loadHomeMovies() async {


    _setState(
        ViewState.loading
    );



    try {


      final trending =
      await _repository
          .getTrendingMovies();




      final popular =
      await _repository
          .getPopularMovies(
          1
      );



      debugPrint(
          "Trending count: ${trending.results.length}"
      );


      debugPrint(
          "Popular count: ${popular.results.length}"
      );



      // IMPORTANT FIX
      _trendingMovies =
          trending.results;



      _popularMovies =
          popular.results;



      _popularPage = 1;



      _setState(
          ViewState.success
      );



    }



    on AppException catch(e){


      _setError(
          e.message
      );


    }



    catch(e){


      debugPrint(
          "HOME ERROR: $e"
      );


      _setError(
          e.toString()
      );


    }


  }







  //==============================================================
  // Load More Popular Movies
  //==============================================================


  Future<void> loadMorePopularMovies() async {


    if(_isLoadingMore) return;



    _isLoadingMore = true;


    notifyListeners();



    try {


      _popularPage++;



      final response =
      await _repository
          .getPopularMovies(
          _popularPage
      );



      _popularMovies
          .addAll(
          response.results
      );



    }


    catch(e){


      _popularPage--;


    }



    _isLoadingMore = false;


    notifyListeners();


  }







  //==============================================================
  // Refresh
  //==============================================================


  Future<void> refresh() async {


    await loadHomeMovies();


  }







  //==============================================================
  // Helpers
  //==============================================================


  void _setState(
      ViewState state
      ){


    _state =
        state;


    notifyListeners();


  }






  void _setError(
      String message
      ){


    _errorMessage =
        message;



    _state =
        ViewState.error;



    notifyListeners();


  }




  void clearError(){


    _errorMessage = null;


    notifyListeners();


  }



}