import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/view_state.dart';

import '../../providers/home_provider.dart';
import '../../providers/favorites_provider.dart';

import '../../models/movie.dart';


import '../../widgets/loading_widget.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/movie_list.dart';

import '../../routes/app_routes.dart';



class HomeScreen extends StatefulWidget {


  const HomeScreen({

    super.key,

  });



  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();


}




class _HomeScreenState
    extends State<HomeScreen> {




  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {


      if(!mounted) return;


      context
          .read<HomeProvider>()
          .loadHomeMovies();


    });


  }






  Future<void> _refresh() async {


    await context
        .read<HomeProvider>()
        .refresh();


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(


        title: const Text(

          'Movie Explorer',

        ),



        centerTitle: false,



        actions: [


          IconButton(

            icon: const Icon(
              Icons.search,
            ),


            onPressed: () {

              Navigator.pushNamed(

                context,

                AppRoutes.search,

              );

            },


          ),





          IconButton(

            icon: const Icon(
              Icons.favorite,
            ),


            onPressed: () {


              Navigator.pushNamed(

                context,

                AppRoutes.favorites,

              );


            },


          ),






          IconButton(

            icon: const Icon(
              Icons.settings,
            ),



            onPressed: () {


              Navigator.pushNamed(

                context,

                AppRoutes.settings,

              );


            },


          ),



        ],



      ),







      body: Consumer<HomeProvider>(


        builder:
            (
            context,
            provider,
            child,
            ){



          switch(provider.state){



            case ViewState.loading:


              return const LoadingWidget();





            case ViewState.error:


              return CustomErrorWidget(


                message:
                provider.errorMessage ??
                    'Something went wrong.',



                onRetry: () {


                  provider.loadHomeMovies();


                },


              );







            case ViewState.empty:


              return const EmptyStateWidget(


                message:
                'No movies found.',


              );







            case ViewState.success:


              return _buildHomeContent(
                  provider
              );







            case ViewState.idle:


              return const LoadingWidget();



          }



        },


      ),



    );


  }









//==============================================================
// Home Content
//==============================================================



  Widget _buildHomeContent(
      HomeProvider provider,
      ){



    return RefreshIndicator(



      onRefresh:
      _refresh,




      child: ListView(



        padding:
        const EdgeInsets.only(


          top: 16,

          bottom: 20,


        ),




        children: [







          _sectionTitle(

            icon:
            Icons.local_fire_department,

            title:
            'Trending Movies',

          ),





          const SizedBox(

            height: 12,

          ),






          MovieList(


            movies:
            provider.trendingMovies,



            onMovieTap:
                (movie){

              _openMovieDetails(
                  movie
              );


            },



            onFavoritePressed:
                (movie){

              _toggleFavorite(
                  movie
              );


            },



            isFavorite:
                (movieId){

              return context
                  .read<FavoritesProvider>()
                  .isFavorite(movieId);


            },



          ),








          const SizedBox(

            height: 32,

          ),







          _sectionTitle(

            icon:
            Icons.star,

            title:
            'Popular Movies',


          ),






          const SizedBox(

            height: 12,

          ),







          MovieList(



            movies:
            provider.popularMovies,



            isLoadingMore:
            provider.isLoadingMore,




            onMovieTap:
                (movie){


              _openMovieDetails(
                  movie
              );


            },




            onFavoritePressed:
                (movie){


              _toggleFavorite(
                  movie
              );


            },





            isFavorite:
                (movieId){


              return context
                  .read<FavoritesProvider>()
                  .isFavorite(movieId);


            },




            onLoadMore: (){


              provider
                  .loadMorePopularMovies();


            },



          ),



        ],


      ),



    );


  }









//==============================================================
// Section Header
//==============================================================



  Widget _sectionTitle({

    required IconData icon,

    required String title,

  }){


    return Padding(


      padding:
      const EdgeInsets.symmetric(

        horizontal: 16,

      ),



      child: Row(


        children: [



          Icon(

            icon,

            size: 26,

          ),




          const SizedBox(

            width: 8,

          ),




          Text(


            title,


            style:
            const TextStyle(


              fontSize: 22,


              fontWeight:
              FontWeight.bold,


            ),



          ),



        ],


      ),


    );


  }









  void _openMovieDetails(
      Movie movie,
      ){


    Navigator.pushNamed(

      context,

      AppRoutes.movieDetails,

      arguments:
      movie.id,

    );


  }








  void _toggleFavorite(
      Movie movie,
      ){


    context
        .read<FavoritesProvider>()
        .toggleFavorite(
      movie,
    );


  }



}