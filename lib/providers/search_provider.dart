import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/exceptions.dart';
import '../core/view_state.dart';

import '../models/movie.dart';

import '../repositories/i_movie_repository.dart';


/// ===============================================================
/// Search Provider
/// ===============================================================
///
/// Handles movie searching.
///
/// Features:
///
/// • Movie search
/// • Debounce typing
/// • Pagination
/// • Loading state
/// • Error handling
///
/// ===============================================================


class SearchProvider extends ChangeNotifier {


  final IMovieRepository _repository;



  SearchProvider({

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
  // Search Data
  //==============================================================


  List<Movie> _movies = [];


  List<Movie> get movies =>
      List.unmodifiable(
          _movies
      );



  String _query = '';



  String get query =>
      _query;





  //==============================================================
  // Pagination
  //==============================================================


  int _page = 1;


  bool _isLoadingMore = false;


  bool get isLoadingMore =>
      _isLoadingMore;



  bool _hasMore = true;


  bool get hasMore =>
      _hasMore;





  //==============================================================
  // Debounce
  //==============================================================


  Timer? _debounce;





  //==============================================================
  // Search Movies
  //==============================================================


  void search(String query) {


    _debounce?.cancel();



    _debounce = Timer(

      const Duration(
        milliseconds: 500,
      ),


          () {

        _performSearch(query);

      },

    );


  }







  Future<void> _performSearch(

      String query,

      ) async {



    if(query.trim().isEmpty){


      clearSearch();


      return;

    }



    _query =
        query;



    _page =
    1;



    _hasMore =
    true;



    _movies.clear();



    _setState(
        ViewState.loading
    );





    try {



      final response =

      await _repository.searchMovies(

        query,

        _page,

      );





      _movies =

          response.results;





      if(response.results.isEmpty){

        _hasMore = false;

      }




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
          "SEARCH ERROR: $e"
      );


      _setError(

          'Something went wrong.'

      );


    }



  }









  //==============================================================
  // Load More Search Results
  //==============================================================


  Future<void> loadMore() async {



    if(_isLoadingMore) return;



    if(!_hasMore) return;



    if(_query.isEmpty) return;





    _isLoadingMore = true;


    notifyListeners();





    try {



      _page++;





      final response =

      await _repository.searchMovies(

        _query,

        _page,

      );





      if(response.results.isEmpty){


        _hasMore = false;


      }

      else{


        _movies.addAll(

            response.results

        );


      }





    }





    catch(e){


      debugPrint(
          "LOAD MORE ERROR: $e"
      );


      _page--;


    }





    _isLoadingMore = false;


    notifyListeners();


  }









  //==============================================================
  // Clear Search
  //==============================================================


  void clearSearch(){



    _debounce?.cancel();



    _query = '';



    _movies.clear();



    _page = 1;



    _hasMore = true;



    _state =
        ViewState.idle;



    notifyListeners();



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








  @override
  void dispose(){


    _debounce?.cancel();


    super.dispose();


  }



}