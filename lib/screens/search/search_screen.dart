import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/view_state.dart';

import '../../models/movie.dart';

import '../../providers/search_provider.dart';
import '../../providers/favorites_provider.dart';

import '../../widgets/search_bar_widget.dart';
import '../../widgets/movie_grid.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/empty_state_widget.dart';


import '../../routes/app_routes.dart';


class SearchScreen extends StatefulWidget {


  const SearchScreen({

    super.key,

  });



  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();


}







class _SearchScreenState
    extends State<SearchScreen> {



//--------------------------------------------------------------
// Controller
//--------------------------------------------------------------


late TextEditingController _searchController;





//--------------------------------------------------------------
// Initialization
//--------------------------------------------------------------


@override
void initState() {


super.initState();



_searchController =
TextEditingController();

}






//--------------------------------------------------------------
// Dispose
//--------------------------------------------------------------


@override
void dispose() {


_searchController.dispose();


super.dispose();


}







//--------------------------------------------------------------
// Search
//--------------------------------------------------------------


void _onSearchChanged(
String query,
) {


context
.read<SearchProvider>()
.search(
query,
);


}







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
// Favorite
//--------------------------------------------------------------


void _toggleFavorite(
Movie movie,
) {
  context
      .read<FavoritesProvider>()
      .toggleFavorite(
    movie,
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
        'Search Movies',
      ),


    ),




    body: Column(


      children: [



        SearchBarWidget(


          controller:
          _searchController,


          onChanged:
          _onSearchChanged,


        ),




        Expanded(


          child:
          Consumer<SearchProvider>(


            builder:
                (
                context,
                provider,
                child,
                ) {



              switch(provider.state){



              //--------------------------------------------------
              // Loading
              //--------------------------------------------------


                case ViewState.loading:


                  return const LoadingWidget();







              //--------------------------------------------------
              // Error
              //--------------------------------------------------


                case ViewState.error:


                  return CustomErrorWidget(


                    message:
                    provider.errorMessage ??
                        'Something went wrong.',



                    onRetry: () {


                      provider.search(
                        provider.query,
                      );


                    },


                  );







              //--------------------------------------------------
              // Empty
              //--------------------------------------------------


                case ViewState.empty:


                  return const EmptyStateWidget(


                    message:
                    'No movies found.',


                  );







              //--------------------------------------------------
              // Success
              //--------------------------------------------------


                case ViewState.success:



                  return NotificationListener<ScrollNotification>(


                    onNotification:
                        (notification) {


                      if(notification.metrics.pixels >=

                          notification.metrics.maxScrollExtent - 200){


                        provider.loadMore();


                      }


                      return false;


                    },



                    child: MovieGrid(



                      movies:
                      provider.movies,



                      onMovieTap:
                          (Movie movie){



                        _openMovieDetails(movie);



                      },





                      onFavoritePressed:
                          (Movie movie){



                        _toggleFavorite(movie);



                      },





                      isFavorite:
                          (int movieId){



                        return context

                            .read<FavoritesProvider>()

                            .isFavorite(
                            movieId
                        );



                      },


                    ),


                  );







              //--------------------------------------------------
              // Idle
              //--------------------------------------------------


                case ViewState.idle:


                  return const Center(


                    child: Text(

                      'Search movies to begin',

                    ),


                  );





              }


            },


          ),


        ),



      ],


    ),


  );


}


}


