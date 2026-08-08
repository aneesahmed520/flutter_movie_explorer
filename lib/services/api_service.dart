import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/api_constants.dart';
import '../core/exceptions.dart';



/// ===============================================================
/// API Service
/// ===============================================================
///
/// Handles all communication with TMDB API.
///
/// Responsibilities:
///
/// • Send HTTP requests
/// • Add API authentication
/// • Decode JSON responses
/// • Handle network errors
///
/// ===============================================================


class ApiService {


  final http.Client _client;



  ApiService({

    http.Client? client,

  }) :

        _client =
            client ?? http.Client();





  //==============================================================
  // GET Request
  //==============================================================


  Future<dynamic> get(
      String endpoint,
      ) async {


    try {


      final uri = Uri.parse(
        '${ApiConstants.baseUrl}$endpoint',
      ).replace(
        queryParameters: {

          ...Uri.parse(
            '${ApiConstants.baseUrl}$endpoint',
          ).queryParameters,

          'api_key': ApiConstants.apiKey,

        },
      );




      debugPrint(
        "API URL: $uri",
      );



      final response =
      await _client.get(


        uri,


        headers: {


          'Accept':
          'application/json',


        },


      );



      return _handleResponse(
        response,
      );


    }



    on http.ClientException {


      throw NetworkException(

        'No internet connection.',

      );


    }



    catch (e) {


      if (e is AppException) {


        rethrow;


      }



      throw ServerException(

        'Something went wrong.',

      );


    }


  }






  //==============================================================
  // Response Handler
  //==============================================================


  dynamic _handleResponse(

      http.Response response,

      ) {



    switch(response.statusCode) {


      case 200:


        return jsonDecode(

          response.body,

        );




      case 401:


        throw ServerException(

          'Invalid API key.',

        );




      case 404:


        throw ServerException(

          'Movie not found.',

        );




      case 500:


        throw ServerException(

          'Server error.',

        );




      default:


        throw ServerException(

          'Unexpected error occurred.',

        );


    }


  }






  //==============================================================
  // Dispose
  //==============================================================


  void dispose() {


    _client.close();


  }



}