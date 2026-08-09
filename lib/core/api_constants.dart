library;


/// ===============================================================

/// API Constants
/// ===============================================================


class ApiConstants {


  static const String baseUrl =
      'https://api.themoviedb.org/3';



  static const String imageBaseUrl =
      'https://image.tmdb.org/t/p/';



  static const String apiKey =
      'YOUR_REAL_KEY';

  static const String posterSize =
      'w500';



  static const String backdropSize =
      'w780';



  static String posterUrl(
      String path,
      ) {


    if (path.isEmpty) {

      return '';

    }


    return
      '$imageBaseUrl$posterSize$path';

  }




  static String backdropUrl(
      String path,
      ) {


    if (path.isEmpty) {

      return '';

    }


    return
      '$imageBaseUrl$backdropSize$path';

  }


}