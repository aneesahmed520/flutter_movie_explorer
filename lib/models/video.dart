library;
/// ===============================================================
/// Movie Video Model
/// ===============================================================
///
/// Represents trailers and videos from TMDB.
///
/// Example:
/// YouTube Trailer
///
/// ===============================================================


class MovieVideo {


  final String id;

  final String key;

  final String name;

  final String site;

  final String type;

  final bool official;



  const MovieVideo({

    required this.id,

    required this.key,

    required this.name,

    required this.site,

    required this.type,

    required this.official,

  });



  //==============================================================
  // From JSON
  //==============================================================


  factory MovieVideo.fromJson(
      Map<String, dynamic> json,
      ) {


    return MovieVideo(

      id:
      json['id'] ?? '',


      key:
      json['key'] ?? '',


      name:
      json['name'] ?? '',


      site:
      json['site'] ?? '',


      type:
      json['type'] ?? '',


      official:
      json['official'] ?? false,

    );

  }



  //==============================================================
  // YouTube URL
  //==============================================================


  String get youtubeUrl {


    return
      'https://www.youtube.com/watch?v=$key';

  }



  //==============================================================
  // Check Trailer
  //==============================================================


  bool get isTrailer {


    return type == 'Trailer';

  }


}