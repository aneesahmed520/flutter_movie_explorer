library;


/// ===============================================================
/// API Response Model
/// ===============================================================
///
/// Generic response wrapper for TMDB APIs.
///
/// Used for:
/// • Popular movies
/// • Trending movies
/// • Search results
/// • Similar movies
///
/// ===============================================================


class ApiResponse<T> {


  final int page;

  final List<T> results;

  final int totalPages;

  final int totalResults;



  const ApiResponse({

    required this.page,

    required this.results,

    required this.totalPages,

    required this.totalResults,

  });



  //==============================================================
  // From JSON
  //==============================================================


  factory ApiResponse.fromJson(

      Map<String, dynamic> json,

      T Function(Map<String, dynamic>) fromJson,

      ) {


    return ApiResponse<T>(

      page:
      json['page'] ?? 1,


      results:
      (json['results'] as List<dynamic>? ?? [])

          .map(
            (item) =>
            fromJson(
              item,
            ),
      )

          .toList(),


      totalPages:
      json['total_pages'] ?? 0,


      totalResults:
      json['total_results'] ?? 0,

    );

  }


}