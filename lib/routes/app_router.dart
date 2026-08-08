import 'package:flutter/material.dart';

import 'route_generator.dart';


/// ===============================================================
/// App Router
/// ===============================================================
///
/// Central navigation entry point.
///
/// MaterialApp uses this class
/// to generate application routes.
///
/// ===============================================================


class AppRouter {


  static Route<dynamic> generateRoute(
      RouteSettings settings,
      ) {


    return RouteGenerator.generateRoute(
      settings,
    );


  }


}