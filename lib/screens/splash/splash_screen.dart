import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';



class SplashScreen extends StatefulWidget {


  const SplashScreen({

    super.key,

  });



  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();


}





class _SplashScreenState
    extends State<SplashScreen> {



  @override
  void initState() {

    super.initState();


    _navigateToHome();

  }






  Future<void> _navigateToHome() async {


    await Future.delayed(

      const Duration(seconds: 2),

    );



    if(!mounted) return;



    Navigator.pushReplacementNamed(

      context,

      AppRoutes.home,

    );


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Center(


        child: Column(


          mainAxisAlignment:
          MainAxisAlignment.center,



          children: [



            const Icon(

              Icons.movie,

              size: 80,

            ),



            const SizedBox(

              height: 20,

            ),




            Text(


              'Movie Explorer',


              style:
              Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(

                fontWeight:
                FontWeight.bold,

              ),


            ),



            const SizedBox(

              height: 30,

            ),




            const CircularProgressIndicator(),



          ],


        ),


      ),


    );


  }


}