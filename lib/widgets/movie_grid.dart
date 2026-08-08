import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_card.dart';



class MovieGrid extends StatelessWidget {


  const MovieGrid({

    super.key,

    required this.movies,

    this.onMovieTap,

    this.onFavoritePressed,

    this.isFavorite,

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




  @override
  Widget build(BuildContext context) {


    if (movies.isEmpty) {


      return const Center(


        child: Text(

          'No movies found',

        ),


      );


    }





    return GridView.builder(



      padding:
      const EdgeInsets.all(12),




      shrinkWrap:
      true,



      physics:
      const NeverScrollableScrollPhysics(),




      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(



        crossAxisCount: 2,



        crossAxisSpacing: 10,



        mainAxisSpacing: 12,



        childAspectRatio: 0.65,



      ),





      itemCount:
      movies.length,





      itemBuilder:
          (
          context,
          index,
          ) {



        final movie =
        movies[index];





        return MovieCard(



          movie:
          movie,





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

          isFavorite?.call(movie.id)

              ??

              false,




        );


      },



    );


  }


}