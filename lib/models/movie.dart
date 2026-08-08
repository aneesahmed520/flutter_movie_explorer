library;

/// ===============================================================
/// Movie Model
/// ===============================================================
///
/// Main movie data model.
///
/// Used throughout the application:
///
/// • Home
/// • Search
/// • Details
/// • Favorites
///
/// ===============================================================


import 'genre.dart';



class Movie {


  final int id;


  final String title;


  final String overview;


  final String posterPath;


  final String backdropPath;


  final double rating;


  final String releaseDate;


  final List<Genre> genres;


  final int? runtime;


  final String? status;


  final String? tagline;


  final String? homepage;

  final String? originalLanguage;


  final int? voteCount;


  final double? popularity;


  const Movie({

    required this.id,

    required this.title,

    required this.overview,

    required this.posterPath,

    required this.backdropPath,

    required this.rating,

    required this.releaseDate,

    this.genres = const [],

    this.runtime,

    this.status,

    this.tagline,

    this.homepage,

    this.originalLanguage,

    this.voteCount,

    this.popularity,

  });




  //==============================================================
  // From JSON
  //==============================================================


  factory Movie.fromJson(
      Map<String, dynamic> json,
      ) {


    return Movie(

      id:
      json['id'] ?? 0,


      title:
      json['title'] ??
          json['name'] ??
          '',


      overview:
      json['overview'] ?? '',



      posterPath:
      json['poster_path'] ?? '',



      backdropPath:
      json['backdrop_path'] ?? '',



      rating:
      double.tryParse(
        json['vote_average'].toString(),
      ) ??
          0.0,



      releaseDate:
      json['release_date'] ??
          json['first_air_date'] ??
          '',



      genres:

      (json['genres'] as List<dynamic>? ?? [])

          .map(
            (item) =>
            Genre.fromJson(item),
      )

          .toList(),



      runtime:
      json['runtime'],



      status:
      json['status'],



      tagline:
      json['tagline'],



      homepage:
      json['homepage'],


      originalLanguage:
      json['original_language'],


      voteCount:
      json['vote_count'],


      popularity:
      double.tryParse(
        json['popularity'].toString(),
      ),

    );

  }




  //==============================================================
  // To JSON
  //==============================================================


  Map<String, dynamic> toJson() {


    return {


      'id': id,


      'title': title,


      'overview': overview,


      'poster_path': posterPath,


      'backdrop_path': backdropPath,


      'vote_average': rating,


      'release_date': releaseDate,


      'genres':

      genres

          .map(
            (genre) =>
            genre.toJson(),
      )

          .toList(),


      'runtime': runtime,


      'status': status,


      'tagline': tagline,


      'homepage': homepage,


      'original_language':
      originalLanguage,


      'vote_count':
      voteCount,


      'popularity':
      popularity,


    };

  }


//==============================================================
// Runtime Helper
//==============================================================


  String get formattedRuntime {


    if(runtime == null){

      return 'N/A';

    }


    final hours =
        runtime! ~/ 60;


    final minutes =
        runtime! % 60;



    if(hours > 0){

      return '${hours}h ${minutes}m';

    }


    return '${minutes}m';


  }

  //==============================================================
  // Image Helpers
  //==============================================================


  String get posterUrl {


    if (posterPath.isEmpty) {

      return '';

    }


    return
      'https://image.tmdb.org/t/p/w500$posterPath';

  }



  String get backdropUrl {


    if (backdropPath.isEmpty) {

      return '';

    }


    return
      'https://image.tmdb.org/t/p/w780$backdropPath';

  }


}