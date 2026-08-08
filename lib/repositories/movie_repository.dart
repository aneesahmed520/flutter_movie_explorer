
import '../core/api_endpoints.dart';
import '../models/api_response.dart';
import '../models/cast.dart';
import '../models/movie.dart';
import '../models/video.dart';
import '../services/api_service.dart';

import 'i_movie_repository.dart';
import 'package:flutter/foundation.dart';


/// ===============================================================
/// Movie Repository Implementation
/// ===============================================================
///
/// Connects:
///
/// ApiService
///      ↓
/// Repository
///      ↓
/// Providers
///
/// Responsibilities:
///
/// • Call API endpoints
/// • Convert JSON to models
/// • Return clean data
///
/// ===============================================================


class MovieRepository implements IMovieRepository {


  final ApiService _apiService;



  MovieRepository({

    required this._apiService,

  });



  //==============================================================
  // Popular Movies
  //==============================================================

  @override
  Future<ApiResponse<Movie>> getPopularMovies(
      int page,
      ) async {


    final json =
    await _apiService.get(

      '${ApiEndpoints.popularMovies}?page=$page',

    );


    debugPrint(
      "POPULAR JSON: $json",
    );


    return ApiResponse<Movie>.fromJson(

      json,

      Movie.fromJson,

    );

  }


  //==============================================================
  // Trending Movies
  //==============================================================


  @override
  Future<ApiResponse<Movie>> getTrendingMovies()
  async {


    final json =
    await _apiService.get(

      ApiEndpoints.trendingMovies,

    );


    debugPrint(
      "TRENDING JSON: $json",
    );


    return ApiResponse<Movie>.fromJson(

      json,

      Movie.fromJson,

    );

  }




  //==============================================================
  // Search Movies
  //==============================================================


  @override
  Future<ApiResponse<Movie>> searchMovies(

      String query,

      int page,

      ) async {


    final json =
    await _apiService.get(

        '${ApiEndpoints.searchMovies}'
            '?query=$query&page=$page'

    );



    return ApiResponse<Movie>.fromJson(

      json,

      Movie.fromJson,

    );

  }




  //==============================================================
  // Movie Details
  //==============================================================


  @override
  Future<Movie> getMovieDetails(

      int movieId,

      ) async {


    final json =
    await _apiService.get(

      ApiEndpoints.movieDetails(
        movieId,
      ),

    );



    return Movie.fromJson(

      json,

    );

  }




  //==============================================================
  // Credits
  //==============================================================


  @override
  Future<List<Cast>> getMovieCredits(

      int movieId,

      ) async {


    final json =
    await _apiService.get(

      ApiEndpoints.movieCredits(
        movieId,
      ),

    );



    final List<dynamic> castJson =
        json['cast'] ?? [];



    return castJson

        .map(

          (item) =>
          Cast.fromJson(item),

    )

        .toList();

  }




  //==============================================================
  // Trailer
  //==============================================================


  @override
  Future<MovieVideo?> getOfficialTrailer(

      int movieId,

      ) async {


    final json =
    await _apiService.get(

      ApiEndpoints.movieVideos(
        movieId,
      ),

    );



    final List<dynamic> videos =
        json['results'] ?? [];



    for (final video in videos) {


      final movieVideo =
      MovieVideo.fromJson(video);



      if (

      movieVideo.site == 'YouTube' &&

          movieVideo.type == 'Trailer' &&

          movieVideo.official

      ) {


        return movieVideo;


      }


    }



    return null;

  }




  //==============================================================
  // Similar Movies
  //==============================================================


  @override
  Future<ApiResponse<Movie>> getSimilarMovies(

      int movieId,

      ) async {


    final json =
    await _apiService.get(

      ApiEndpoints.similarMovies(
        movieId,
      ),

    );



    return ApiResponse<Movie>.fromJson(

      json,

      Movie.fromJson,

    );

  }


}