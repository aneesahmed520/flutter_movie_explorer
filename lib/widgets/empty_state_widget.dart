import 'package:flutter/material.dart';


/// ===============================================================
/// Empty State Widget
/// ===============================================================
///
/// Displays empty content message.
///
/// Used in:
///
/// • Search Screen
/// • Favorites Screen
/// • Movie Lists
///
/// ===============================================================


class EmptyStateWidget extends StatelessWidget {


  const EmptyStateWidget({

    super.key,

    this.message = 'No data available',

    this.icon = Icons.inbox,

  });



  final String message;

  final IconData icon;



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


            Icon(

              icon,

              size: 70,

              color:
              Colors.grey,

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



          ],

        ),

      ),

    );


  }


}