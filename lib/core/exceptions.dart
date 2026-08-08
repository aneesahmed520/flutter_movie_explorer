library;

/// ===============================================================
/// Application Exceptions
/// ===============================================================


class AppException implements Exception {


  final String message;


  AppException(
      this.message,
      );


  @override
  String toString() {

    return message;

  }

}




class NetworkException extends AppException {


  NetworkException(
      super.message,
      );

}




class ServerException extends AppException {


  ServerException(
      super.message,
      );

}




class ParsingException extends AppException {


  ParsingException(
      super.message,
      );

}