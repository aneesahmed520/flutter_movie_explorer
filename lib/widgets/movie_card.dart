import 'package:flutter/material.dart';

import '../models/movie.dart';

import 'rating_chip.dart';
import 'favorite_button.dart';



/// ===============================================================
/// Movie Card Widget
/// ===============================================================
///
/// Displays a single movie.
///
/// Features:
///
/// • Poster image
/// • Hero animation
/// • Movie title
/// • Rating
/// • Favorite action
/// • Tap callback
///
/// Used in:
///
/// • Home
/// • Search
/// • Favorites
/// • Similar Movies
///
/// ===============================================================


class MovieCard extends StatelessWidget {


  const MovieCard({

    super.key,

    required this.movie,

    this.onTap,

    this.onFavoritePressed,

    this.isFavorite = false,

  });



  //--------------------------------------------------------------
  // Data
  //--------------------------------------------------------------


  final Movie movie;




  //--------------------------------------------------------------
  // Callbacks
  //--------------------------------------------------------------


  final VoidCallback? onTap;


  final VoidCallback? onFavoritePressed;


  final bool isFavorite;






  @override
  Widget build(BuildContext context) {


    return GestureDetector(


      onTap: onTap,



      child: SizedBox(


        width: 150,



        child: Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,



          children: [





            //====================================================
            // Poster + Hero Animation
            //====================================================


            Stack(


              children: [



                Hero(


                  tag:
                  'movie_${movie.id}',



                  child: ClipRRect(


                    borderRadius:
                    BorderRadius.circular(12),



                    child: Image.network(


                      movie.posterUrl,



                      height: 210,


                      width: 150,



                      fit:
                      BoxFit.cover,



                      errorBuilder:

                          (
                          context,
                          error,
                          stackTrace,
                          ){

                        return Container(


                          height: 210,


                          width: 150,



                          decoration:
                          BoxDecoration(


                            color:
                            Colors.grey.shade300,



                            borderRadius:
                            BorderRadius.circular(12),


                          ),



                          child:
                          const Icon(


                            Icons.movie,


                            size: 50,


                          ),


                        );


                      },


                    ),


                  ),


                ),







                //================================================
                // Favorite Button
                //================================================



                Positioned(


                  top: 8,


                  right: 8,



                  child: FavoriteButton(


                    isFavorite:
                    isFavorite,



                    onPressed:
                    onFavoritePressed,


                  ),


                ),







                //================================================
                // Rating
                //================================================



                Positioned(


                  bottom: 8,


                  left: 8,



                  child: RatingChip(


                    rating:
                    movie.rating,


                  ),


                ),



              ],


            ),







            const SizedBox(


              height: 8,


            ),







            //====================================================
            // Movie Title
            //====================================================



            Text(


              movie.title,



              maxLines:
              2,



              overflow:
              TextOverflow.ellipsis,



              style:
              const TextStyle(


                fontWeight:
                FontWeight.bold,



                fontSize: 15,


              ),


            ),



          ],


        ),


      ),


    );


  }


}