import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';

import '../../providers/favorites_provider.dart';

import '../../widgets/movie_grid.dart';
import '../../widgets/empty_state_widget.dart';

import '../../routes/app_routes.dart';



class FavoritesScreen extends StatefulWidget {


  const FavoritesScreen({

    super.key,

  });



  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();


}




class _FavoritesScreenState
    extends State<FavoritesScreen> {





  //--------------------------------------------------------------
  // Open Movie Details
  //--------------------------------------------------------------


  void _openMovieDetails(
      Movie movie,
      ) {


    Navigator.pushNamed(

      context,

      AppRoutes.movieDetails,

      arguments: movie.id,

    );


  }






  //--------------------------------------------------------------
  // Remove Favorite
  //--------------------------------------------------------------


  void _removeFavorite(
      Movie movie,
      ) {


    context
        .read<FavoritesProvider>()
        .removeFavorite(movie);


  }







  //--------------------------------------------------------------
  // Clear All Favorites
  //--------------------------------------------------------------


  void _clearAllFavorites() {


    showDialog(


      context: context,


      builder: (context) {


        return AlertDialog(


          title: const Text(
            'Clear Favorites?',
          ),



          content: const Text(

            'Are you sure you want to remove all favorite movies?',

          ),




          actions: [



            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },


              child: const Text(
                'Cancel',
              ),

            ),





            ElevatedButton(


              onPressed: () {


                context
                    .read<FavoritesProvider>()
                    .clearFavorites();



                Navigator.pop(context);


              },



              child: const Text(
                'Clear',
              ),


            ),



          ],


        );


      },

    );


  }








  //--------------------------------------------------------------
  // Build
  //--------------------------------------------------------------


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(


        title: Consumer<FavoritesProvider>(


          builder: (

              context,

              provider,

              child,

              ){

            return Text(

              'Favorites (${provider.favoritesCount})',

            );


          },

        ),




        actions: [



          Consumer<FavoritesProvider>(


            builder: (

                context,

                provider,

                child,

                ){


              if(provider.favorites.isEmpty){

                return const SizedBox();

              }



              return IconButton(


                icon:

                const Icon(

                  Icons.delete_sweep,

                ),



                tooltip:

                'Clear Favorites',



                onPressed:

                _clearAllFavorites,



              );


            },


          ),



        ],



      ),







      body:

      Consumer<FavoritesProvider>(


        builder:

            (

            context,

            provider,

            child,

            ){



          //--------------------------------------------------------
          // Empty State
          //--------------------------------------------------------


          if(provider.favorites.isEmpty){


            return const EmptyStateWidget(


              message:

              'No favorite movies yet.\nAdd movies you love ❤️',



              icon:

              Icons.favorite_border,


            );


          }








          //--------------------------------------------------------
          // Movie Grid
          //--------------------------------------------------------


          return Padding(


            padding:

            const EdgeInsets.all(8),



            child: MovieGrid(


              movies:

              provider.favorites,





              onMovieTap:

                  (movie){


                _openMovieDetails(movie);


              },





              onFavoritePressed:

                  (movie){


                _removeFavorite(movie);


              },






              isFavorite:

                  (movieId){


                return provider

                    .isFavorite(movieId);


              },



            ),


          );



        },


      ),



    );


  }



}