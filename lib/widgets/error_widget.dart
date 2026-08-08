import 'package:flutter/material.dart';


/// ===============================================================
/// App Error Widget
/// ===============================================================
///
/// Generic application error widget.
///
/// Features:
///
/// • Error icon
/// • Error message
/// • Retry button
///
/// Used in:
///
/// • Screens
/// • API failure states
/// • Loading failures
///
/// ===============================================================


class AppErrorWidget extends StatelessWidget {


  const AppErrorWidget({

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

              Icons.cloud_off,

              size: 70,

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


              ElevatedButton(

                onPressed:
                onRetry,


                child:
                const Text(

                  'Try Again',

                ),

              ),



          ],

        ),

      ),

    );


  }


}