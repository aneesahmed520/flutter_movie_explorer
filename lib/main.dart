import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';

import 'services/api_service.dart';

import 'repositories/movie_repository.dart';
import 'repositories/i_movie_repository.dart';

import 'providers/home_provider.dart';
import 'providers/search_provider.dart';
import 'providers/movie_details_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/theme_provider.dart';



import 'routes/app_routes.dart';

import 'routes/app_router.dart';
void main() async {


  WidgetsFlutterBinding.ensureInitialized();



  final apiService =
  ApiService();



  final IMovieRepository repository =
  MovieRepository(
    apiService: apiService,
  );



  final themeProvider =
  ThemeProvider();


  await themeProvider.loadTheme();



  final favoritesProvider =
  FavoritesProvider();


  await favoritesProvider.initializeFavorites();



  runApp(

    MovieExplorerApp(

      repository: repository,

      themeProvider: themeProvider,

      favoritesProvider: favoritesProvider,

    ),

  );

}





class MovieExplorerApp extends StatelessWidget {


  final IMovieRepository repository;


  final ThemeProvider themeProvider;


  final FavoritesProvider favoritesProvider;



  const MovieExplorerApp({

    super.key,

    required this.repository,

    required this.themeProvider,

    required this.favoritesProvider,

  });





  @override
  Widget build(BuildContext context) {


    return MultiProvider(


      providers: [


        ChangeNotifierProvider.value(

          value: themeProvider,

        ),



        ChangeNotifierProvider.value(

          value: favoritesProvider,

        ),



        ChangeNotifierProvider(

          create: (_) => HomeProvider(

            repository: repository,

          ),

        ),



        ChangeNotifierProvider(

          create: (_) => SearchProvider(

            repository: repository,

          ),

        ),



        ChangeNotifierProvider(

          create: (_) => MovieDetailsProvider(

            repository: repository,

          ),

        ),


      ],



      child: Consumer<ThemeProvider>(


        builder: (

            context,

            theme,

            child,

            ) {


          return MaterialApp(


            debugShowCheckedModeBanner: false,



            title:
            'Movie Explorer',



            theme:
            AppTheme.lightTheme,



            darkTheme:
            AppTheme.darkTheme,



            themeMode:
            theme.themeMode,



            initialRoute:
            AppRoutes.splash,

            onGenerateRoute:
            AppRouter.generateRoute,

          );


        },

      ),


    );


  }

}