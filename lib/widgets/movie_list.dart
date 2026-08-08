import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_card.dart';



/// ===============================================================
/// Movie List Widget
///
/// Horizontal movie carousel
///
/// Used in:
/// • Home Screen
/// • Details Screen
///
/// ===============================================================


class MovieList extends StatelessWidget {


  const MovieList({

    super.key,

    required this.movies,

    this.onMovieTap,

    this.onFavoritePressed,

    this.isFavorite,

    this.isLoadingMore = false,

    this.onLoadMore,

  });



  //--------------------------------------------------------------
  // Data
  //--------------------------------------------------------------


  final List<Movie> movies;



  //--------------------------------------------------------------
  // Callbacks
  //--------------------------------------------------------------


  final void Function(Movie movie)? onMovieTap;


  final void Function(Movie movie)? onFavoritePressed;


  final bool Function(int movieId)? isFavorite;



  final bool isLoadingMore;


  final VoidCallback? onLoadMore;





  @override
  Widget build(BuildContext context) {



    if (movies.isEmpty) {


      return const SizedBox(


        height: 240,


        child: Center(


          child: Text(

            'No movies available',

          ),


        ),


      );


    }






    return SizedBox(


      height: 285,



      child: ListView.separated(


        scrollDirection:
        Axis.horizontal,



        physics:
        const BouncingScrollPhysics(),



        padding:
        const EdgeInsets.symmetric(

          horizontal: 16,

        ),



        itemCount:
        movies.length +
            (isLoadingMore ? 1 : 0),




        separatorBuilder:
            (
            context,
            index,
            ){


          return const SizedBox(

            width: 14,

          );


        },





        itemBuilder:
            (
            context,
            index,
            ){



          //------------------------------------------------------
          // Loading Indicator
          //------------------------------------------------------


          if(index == movies.length){


            return const SizedBox(


              width: 70,


              child: Center(


                child:
                CircularProgressIndicator(),


              ),


            );


          }






          final movie =
          movies[index];





          return MovieCard(


            movie: movie,



            onTap: () {


              if(onMovieTap != null){


                onMovieTap!(movie);


              }


            },



            onFavoritePressed: () {


              if(onFavoritePressed != null){


                onFavoritePressed!(movie);


              }


            },



            isFavorite:
            isFavorite?.call(movie.id) ?? false,


          );


        },


      ),


    );


  }


}