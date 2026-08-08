import '../models/api_response.dart';
import '../models/cast.dart';
import '../models/movie.dart';
import '../models/video.dart';



/// ===============================================================
/// Movie Repository Interface
/// ===============================================================
///
/// Defines all movie operations.
///
/// Providers depend on this interface,
/// not the API implementation.
///
/// ===============================================================


abstract class IMovieRepository {



  //==============================================================
  // Home Movies
  //==============================================================


  Future<ApiResponse<Movie>> getPopularMovies(
      int page,
      );



  Future<ApiResponse<Movie>> getTrendingMovies();



  Future<ApiResponse<Movie>> searchMovies(
      String query,
      int page,
      );



  //==============================================================
  // Details
  //==============================================================


  Future<Movie> getMovieDetails(
      int movieId,
      );



  Future<List<Cast>> getMovieCredits(
      int movieId,
      );



  Future<MovieVideo?> getOfficialTrailer(
      int movieId,
      );



  Future<ApiResponse<Movie>> getSimilarMovies(
      int movieId,
      );

}