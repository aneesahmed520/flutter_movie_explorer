import 'package:flutter/material.dart';


import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/details/movie_detail_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/settings/settings_screen.dart';


import 'app_routes.dart';





class RouteGenerator {



  static Route<dynamic> generateRoute(
      RouteSettings settings,
      ) {


    switch(settings.name) {



    //============================================================
    // Splash
    //============================================================


      case AppRoutes.splash:


        return MaterialPageRoute(

          builder: (_) =>
          const SplashScreen(),

        );





    //============================================================
    // Home
    //============================================================


      case AppRoutes.home:


        return MaterialPageRoute(

          builder: (_) =>
          const HomeScreen(),

        );





    //============================================================
    // Search
    //============================================================


      case AppRoutes.search:


        return MaterialPageRoute(

          builder: (_) =>
          const SearchScreen(),

        );





    //============================================================
    // Favorites
    //============================================================


      case AppRoutes.favorites:


        return MaterialPageRoute(

          builder: (_) =>
          const FavoritesScreen(),

        );





    //============================================================
    // Settings
    //============================================================


      case AppRoutes.settings:


        return MaterialPageRoute(

          builder: (_) =>
          const SettingsScreen(),

        );





    //============================================================
    // Movie Details
    //============================================================


      case AppRoutes.movieDetails:



        final movieId =
        settings.arguments as int;



        return MaterialPageRoute(


          builder: (_) => MovieDetailScreen(


            movieId: movieId,


          ),


        );







    //============================================================
    // Unknown Route
    //============================================================


      default:


        return MaterialPageRoute(


          builder: (_) => Scaffold(


            body: Center(


              child: Text(

                'Route not found: ${settings.name}',

              ),


            ),


          ),


        );


    }


  }


}