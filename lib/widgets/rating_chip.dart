import 'package:flutter/material.dart';


/// ===============================================================
/// Rating Chip Widget
/// ===============================================================
///
/// Displays movie rating.
///
/// Example:
///
/// ⭐ 8.5
///
/// Used in:
///
/// • Movie Card
/// • Movie Details Screen
///
/// ===============================================================


class RatingChip extends StatelessWidget {


  const RatingChip({

    super.key,

    required this.rating,

  });



  //--------------------------------------------------------------
  // Data
  //--------------------------------------------------------------

  final double rating;




  @override
  Widget build(BuildContext context) {


    return Container(

      padding:
      const EdgeInsets.symmetric(

        horizontal: 8,

        vertical: 4,

      ),



      decoration:
      BoxDecoration(

        color:
        Colors.black87,


        borderRadius:
        BorderRadius.circular(8),


      ),




      child: Row(

        mainAxisSize:
        MainAxisSize.min,


        children: [


          const Icon(

            Icons.star,

            color:
            Colors.amber,

            size: 16,

          ),



          const SizedBox(

            width: 4,

          ),



          Text(

            rating.toStringAsFixed(1),


            style:
            const TextStyle(

              color:
              Colors.white,

              fontWeight:
              FontWeight.bold,

              fontSize: 12,

            ),

          ),



        ],


      ),


    );


  }


}
