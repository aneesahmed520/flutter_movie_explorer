import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/view_state.dart';

import '../../models/movie.dart';

import '../../providers/movie_details_provider.dart';
import '../../providers/favorites_provider.dart';

import '../../widgets/loading_widget.dart';
import '../../widgets/custom_error_widget.dart';

import '../../widgets/favorite_button.dart';
import '../../widgets/rating_chip.dart';

import '../../widgets/movie_list.dart';
import '../../routes/app_routes.dart';



class MovieDetailScreen extends StatefulWidget {


  final int movieId;



  const MovieDetailScreen({

    super.key,

    required this.movieId,

  });



  @override
  State<MovieDetailScreen> createState() =>
      _MovieDetailScreenState();


}






class _MovieDetailScreenState
    extends State<MovieDetailScreen> {



  //--------------------------------------------------------------
  // Initialization
  //--------------------------------------------------------------


  @override
  void initState() {

    super.initState();



    WidgetsBinding.instance
        .addPostFrameCallback((_) {


      if(!mounted) return;



      context
          .read<MovieDetailsProvider>()
          .loadMovie(
          widget.movieId
      );


    });


  }






  //--------------------------------------------------------------
  // Refresh
  //--------------------------------------------------------------


  Future<void> _refresh() async {


    await context
        .read<MovieDetailsProvider>()
        .refresh();


  }






  //--------------------------------------------------------------
  // Favorite
  //--------------------------------------------------------------


  void _toggleFavorite(
      Movie movie,
      ) {


    context
        .read<FavoritesProvider>()
        .toggleFavorite(
        movie
    );


  }






  //--------------------------------------------------------------
  // Build
  //--------------------------------------------------------------


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(


        title: const Text(
          'Movie Details',
        ),


      ),



      body: Consumer<MovieDetailsProvider>(


        builder: (

            context,

            provider,

            child,

            ) {



          switch(provider.state){



            case ViewState.loading:


              return const LoadingWidget();





            case ViewState.error:


              return CustomErrorWidget(


                message:
                provider.errorMessage ??
                    'Something went wrong.',



                onRetry: () {


                  provider.retry();


                },


              );







            case ViewState.success:


              if(provider.movie == null){


                return const Center(

                  child: Text(
                    'Movie not found',
                  ),

                );


              }



              return _buildContent(

                provider.movie!,

                provider,

              );







            case ViewState.idle:


              return const LoadingWidget();





            case ViewState.empty:


              return const Center(

                child: Text(
                  'No data available',
                ),

              );



          }


        },


      ),


    );


  }






  //--------------------------------------------------------------
  // Content (Part 2 will continue here)
  //--------------------------------------------------------------


  Widget _buildContent(

      Movie movie,

      MovieDetailsProvider provider,

      ) {


    final isFavorite =
    context
        .watch<FavoritesProvider>()
        .isFavorite(movie.id);



    return RefreshIndicator(


      onRefresh:
      _refresh,



      child: SingleChildScrollView(


        physics:
        const AlwaysScrollableScrollPhysics(),



        child: Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,



          children: [



            //----------------------------------------------------------
            // Backdrop
            //----------------------------------------------------------


            Stack(


              children: [


                SizedBox(


                  height: 240,


                  width: double.infinity,



                  child: movie.backdropUrl.isEmpty

                      ? Container(

                    color:
                    Colors.grey.shade300,


                    child:
                    const Icon(

                      Icons.movie,

                      size: 60,

                    ),


                  )


                      : Image.network(


                    movie.backdropUrl,


                    fit:
                    BoxFit.cover,


                    errorBuilder:
                        (
                        context,
                        error,
                        stackTrace,
                        ){

                      return Container(

                        color:
                        Colors.grey.shade300,


                        child:
                        const Icon(

                          Icons.movie,

                          size: 60,

                        ),

                      );

                    },


                  ),



                ),





                Positioned(


                  right: 16,

                  bottom: 16,


                  child: FavoriteButton(


                    isFavorite:
                    isFavorite,


                    onPressed: (){


                      _toggleFavorite(movie);


                    },


                  ),



                ),



              ],


            ),







            //----------------------------------------------------------
            // Movie Information
            //----------------------------------------------------------


            Padding(


              padding:
              const EdgeInsets.all(16),



              child: Column(


                crossAxisAlignment:
                CrossAxisAlignment.start,



                children: [

                  Center(

                    child: Hero(

                      tag: 'movie_${movie.id}',


                      child: ClipRRect(

                        borderRadius:
                        BorderRadius.circular(16),


                        child: Image.network(

                          movie.posterUrl,


                          height: 300,


                          width: 200,


                          fit: BoxFit.cover,


                        ),

                      ),

                    ),

                  ),


                  const SizedBox(

                    height: 20,

                  ),
                  Text(


                    movie.title,


                    style:
                    const TextStyle(


                      fontSize: 26,


                      fontWeight:
                      FontWeight.bold,


                    ),



                  ),





                  const SizedBox(

                    height: 12,

                  ),





                  Row(

                    children: [


                      RatingChip(

                        rating:
                        movie.rating,

                      ),



                      const SizedBox(

                        width: 12,

                      ),



                      Text(

                        movie.releaseDate.isEmpty

                            ? 'N/A'

                            : movie.releaseDate,


                        style:
                        const TextStyle(

                          fontSize: 15,

                        ),

                      ),



                    ],

                  ),





                  const SizedBox(

                    height: 20,

                  ),



                  _buildMovieInfoCard(movie),



                  const SizedBox(

                    height: 20,

                  ),



                  const Text(

                    'Overview',

                    style:
                    TextStyle(

                      fontSize: 20,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),




                  const SizedBox(

                    height: 8,

                  ),




                  Text(


                    movie.overview.isEmpty

                        ? 'No overview available.'

                        : movie.overview,



                    style:
                    const TextStyle(

                      fontSize: 16,

                      height: 1.5,

                    ),


                  ),


                  const SizedBox(

                    height: 24,

                  ),


// Trailer

                  _buildTrailerSection(provider),



                  const SizedBox(

                    height: 24,

                  ),



// Cast

                  _buildCastSection(provider),



                  const SizedBox(

                    height: 24,

                  ),



// Similar Movies

                  _buildSimilarMovies(provider),



                ],


              ),


            ),



          ],


        ),


      ),


    );


  }


//==============================================================
// Cast Section
//==============================================================


  Widget _buildCastSection(
      MovieDetailsProvider provider,
      ) {


    if(provider.cast.isEmpty){

      return const SizedBox();

    }



    return Column(


      crossAxisAlignment:
      CrossAxisAlignment.start,


      children: [


        const Text(

          'Cast',

          style:
          TextStyle(

            fontSize: 20,

            fontWeight:
            FontWeight.bold,

          ),

        ),



        const SizedBox(

          height: 12,

        ),




        SizedBox(


          height: 160,


          child: ListView.builder(


            scrollDirection:
            Axis.horizontal,



            itemCount:
            provider.cast.length,



            itemBuilder:
                (
                context,
                index,
                ){

              final cast =
              provider.cast[index];



              return Container(


                width: 110,


                margin:
                const EdgeInsets.only(

                  right: 12,

                ),



                child: Column(


                  children: [


                    CircleAvatar(


                      radius: 40,


                      backgroundImage:
                      cast.profileUrl != null

                          ? NetworkImage(
                          cast.profileUrl!
                      )

                          : null,


                      child:
                      cast.profileUrl == null

                          ? const Icon(
                        Icons.person,
                      )

                          : null,


                    ),




                    const SizedBox(

                      height: 8,

                    ),




                    Text(


                      cast.name,


                      maxLines: 1,


                      overflow:
                      TextOverflow.ellipsis,

                    ),




                    Text(


                      cast.character,


                      maxLines: 1,


                      overflow:
                      TextOverflow.ellipsis,


                      style:
                      const TextStyle(

                        fontSize: 12,

                      ),


                    ),



                  ],


                ),


              );


            },


          ),


        ),



      ],


    );


  }






//==============================================================
// Trailer Section
//==============================================================

  Widget _buildTrailerSection(
      MovieDetailsProvider provider,
      ) {


    if(provider.trailer == null){

      return const SizedBox();

    }



    return ElevatedButton.icon(


      icon:
      const Icon(
        Icons.play_arrow,
      ),



      label:
      const Text(
        'Watch Trailer',
      ),



      onPressed: () async {


        final url =
        Uri.parse(
          provider.trailer!.youtubeUrl,
        );



        if(await canLaunchUrl(url)){


          await launchUrl(

            url,

            mode:
            LaunchMode.externalApplication,

          );


        }


      },


    );


  }






//==============================================================
// Similar Movies
//==============================================================


  Widget _buildSimilarMovies(
      MovieDetailsProvider provider,
      ){


    if(provider.similarMovies.isEmpty){

      return const SizedBox();

    }




    return Column(


      crossAxisAlignment:
      CrossAxisAlignment.start,


      children: [



        const Text(


          'Similar Movies',


          style:
          TextStyle(


            fontSize: 20,


            fontWeight:
            FontWeight.bold,


          ),


        ),




        const SizedBox(

          height: 12,

        ),





        MovieList(

          movies:
          provider.similarMovies,


          onMovieTap: (Movie movie) {


            Navigator.pushNamed(
              context,
              AppRoutes.movieDetails,
              arguments: movie.id,
            );


          },


        ),




      ],


    );


  }


  //==============================================================
// Movie Information Card
//==============================================================


  Widget _buildMovieInfoCard(Movie movie){


    return Card(

      elevation: 2,


      child: Padding(

        padding:
        const EdgeInsets.all(16),


        child: Column(

          children: [


            _infoRow(

              Icons.timer,

              'Runtime',

              movie.formattedRuntime,

            ),



            _infoRow(

              Icons.language,

              'Language',

              movie.originalLanguage ?? 'N/A',

            ),



            _infoRow(

              Icons.info,

              'Status',

              movie.status ?? 'N/A',

            ),



            _infoRow(

              Icons.people,

              'Votes',

              movie.voteCount?.toString() ?? 'N/A',

            ),



            _infoRow(

              Icons.trending_up,

              'Popularity',

              movie.popularity
                  ?.toStringAsFixed(1)
                  ??
                  'N/A',

            ),



          ],

        ),

      ),

    );


  }




  Widget _infoRow(

      IconData icon,

      String title,

      String value,

      ){


    return Padding(

      padding:
      const EdgeInsets.symmetric(

        vertical: 6,

      ),


      child: Row(

        children: [


          Icon(

            icon,

            size: 20,

          ),



          const SizedBox(

            width: 12,

          ),



          Text(

            title,

            style:
            const TextStyle(

              fontWeight:
              FontWeight.bold,

            ),

          ),



          const Spacer(),



          Text(

            value,

          ),


        ],

      ),

    );


  }


}