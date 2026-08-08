library;


/// ===============================================================
/// Cast Model
/// ===============================================================
///
/// Represents movie cast members.
///
/// ===============================================================


class Cast {


  final int id;

  final String name;

  final String character;

  final String? profilePath;



  const Cast({

    required this.id,

    required this.name,

    required this.character,

    this.profilePath,

  });



  //==============================================================
  // From JSON
  //==============================================================


  factory Cast.fromJson(
      Map<String, dynamic> json,
      ) {


    return Cast(

      id: json['id'] ?? 0,


      name:
      json['name'] ?? '',


      character:
      json['character'] ?? '',


      profilePath:
      json['profile_path'],

    );

  }



  //==============================================================
  // Image URL helper
  //==============================================================


  String? get profileUrl {


    if (profilePath == null ||
        profilePath!.isEmpty) {

      return null;

    }


    return
      'https://image.tmdb.org/t/p/w500$profilePath';

  }


}