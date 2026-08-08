library;


/// ===============================================================
/// TMDB API Endpoints
/// ===============================================================


class ApiEndpoints {


  //==============================================================
  // Movies
  //==============================================================


  static const String trendingMovies =
      '/trending/movie/week';



  static const String popularMovies =
      '/movie/popular';



  static const String topRatedMovies =
      '/movie/top_rated';



  static const String searchMovies =
      '/search/movie';



  static String movieDetails(
      int movieId,
      ) {

    return '/movie/$movieId';

  }



  static String movieCredits(
      int movieId,
      ) {

    return '/movie/$movieId/credits';

  }



  static String movieVideos(
      int movieId,
      ) {

    return '/movie/$movieId/videos';

  }



  static String similarMovies(
      int movieId,
      ) {

    return '/movie/$movieId/similar';

  }


}