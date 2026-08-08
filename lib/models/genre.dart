library;
/// ===============================================================
/// Genre Model
/// ===============================================================
///
/// Represents movie genres from TMDB.
///
/// Example:
/// Action
/// Adventure
///
/// ===============================================================


class Genre {


  final int id;

  final String name;



  const Genre({

    required this.id,

    required this.name,

  });



  //==============================================================
  // From JSON
  //==============================================================

  factory Genre.fromJson(
      Map<String, dynamic> json,
      ) {


    return Genre(

      id: json['id'] ?? 0,

      name: json['name'] ?? '',

    );

  }



  //==============================================================
  // To JSON
  //==============================================================

  Map<String, dynamic> toJson() {


    return {

      'id': id,

      'name': name,

    };

  }


}