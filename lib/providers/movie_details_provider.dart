import 'package:flutter/foundation.dart';

import '../core/exceptions.dart';
import '../core/view_state.dart';

import '../models/cast.dart';
import '../models/movie.dart';
import '../models/video.dart';

import '../repositories/i_movie_repository.dart';


/// ===============================================================
/// Movie Details Provider
/// ===============================================================
///
/// Manages Movie Details Screen.
///
/// Handles:
///
/// • Movie information
/// • Cast
/// • Trailer
/// • Similar movies
/// • Loading state
/// • Errors
///
/// ===============================================================


class MovieDetailsProvider extends ChangeNotifier {


  final IMovieRepository _repository;



  MovieDetailsProvider({

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
  // Movie
  //==============================================================


  Movie? _movie;


  Movie? get movie =>
      _movie;



  int? _movieId;



  //==============================================================
  // Cast
  //==============================================================


  List<Cast> _cast = [];


  List<Cast> get cast =>
      List.unmodifiable(
          _cast
      );



  //==============================================================
  // Similar Movies
  //==============================================================


  List<Movie> _similarMovies = [];


  List<Movie> get similarMovies =>
      List.unmodifiable(
          _similarMovies
      );



  //==============================================================
  // Trailer
  //==============================================================


  MovieVideo? _trailer;


  MovieVideo? get trailer =>
      _trailer;




  //==============================================================
  // Load Movie
  //==============================================================


  Future<void> loadMovie(
      int movieId,
      ) async {


    if(_state == ViewState.loading){

      return;

    }



    _movieId =
        movieId;



    _clearData();



    _setState(
        ViewState.loading
    );



    try {



      await Future.wait([


        _loadDetails(movieId),


        _loadCast(movieId),


        _loadTrailer(movieId),


        _loadSimilar(movieId),


      ]);



      _setState(
          ViewState.success
      );



    }


    on AppException catch(e){


      _setError(
          e.message
      );


    }


    catch(_){


      _setError(
          'Something went wrong.'
      );


    }


  }





  //==============================================================
  // Details
  //==============================================================


  Future<void> _loadDetails(
      int movieId,
      ) async {


    _movie =
    await _repository
        .getMovieDetails(
        movieId
    );

  }





  //==============================================================
  // Cast
  //==============================================================


  Future<void> _loadCast(
      int movieId,
      ) async {


    _cast =
    await _repository
        .getMovieCredits(
        movieId
    );

  }





  //==============================================================
  // Trailer
  //==============================================================


  Future<void> _loadTrailer(
      int movieId,
      ) async {


    _trailer =
    await _repository
        .getOfficialTrailer(
        movieId
    );

  }





  //==============================================================
  // Similar Movies
  //==============================================================


  Future<void> _loadSimilar(
      int movieId,
      ) async {


    final response =
    await _repository
        .getSimilarMovies(
        movieId
    );


    _similarMovies =
        response.results;


  }





  //==============================================================
  // Refresh
  //==============================================================


  Future<void> refresh() async {


    if(_movieId == null){

      return;

    }


    await loadMovie(
        _movieId!
    );


  }





  //==============================================================
  // Retry
  //==============================================================


  Future<void> retry() async {


    await refresh();


  }





  //==============================================================
  // Helpers
  //==============================================================


  void _clearData(){


    _movie = null;


    _cast.clear();


    _similarMovies.clear();


    _trailer = null;


    _errorMessage = null;


  }





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