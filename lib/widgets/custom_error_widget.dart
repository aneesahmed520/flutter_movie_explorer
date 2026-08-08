import 'package:flutter/material.dart';


/// ===============================================================
/// Custom Error Widget
/// ===============================================================
///
/// Displays application errors.
///
/// Used in:
///
/// • Home Screen
/// • Search Screen
/// • Details Screen
///
/// Features:
///
/// • Error message
/// • Retry button
///
/// ===============================================================


class CustomErrorWidget extends StatelessWidget {


  const CustomErrorWidget({

    super.key,

    required this.message,

    this.onRetry,

  });



  //--------------------------------------------------------------
  // Data
  //--------------------------------------------------------------

  final String message;



  //--------------------------------------------------------------
  // Callback
  //--------------------------------------------------------------

  final VoidCallback? onRetry;




  @override
  Widget build(BuildContext context) {


    return Center(


      child: Padding(

        padding:
        const EdgeInsets.all(24),


        child: Column(


          mainAxisSize:
          MainAxisSize.min,



          children: [



            const Icon(

              Icons.error_outline,

              size: 70,

              color: Colors.red,

            ),




            const SizedBox(

              height: 16,

            ),




            Text(

              message,

              textAlign:
              TextAlign.center,


              style:
              Theme.of(context)
                  .textTheme
                  .bodyLarge,


            ),




            const SizedBox(

              height: 20,

            ),




            if(onRetry != null)

              ElevatedButton.icon(

                onPressed:
                onRetry,


                icon:
                const Icon(
                  Icons.refresh,
                ),


                label:
                const Text(
                  'Retry',
                ),

              ),



          ],


        ),


      ),


    );


  }


}