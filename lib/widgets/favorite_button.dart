import 'package:flutter/material.dart';


/// ===============================================================
/// Animated Favorite Button Widget
///
/// Features:
///
/// • Heart animation
/// • Scale bounce effect
/// • Smooth color transition
/// • Reusable widget
///
/// Used in:
///
/// • Movie Card
/// • Movie Details Screen
///
/// ===============================================================


class FavoriteButton extends StatefulWidget {


  const FavoriteButton({

    super.key,

    required this.isFavorite,

    this.onPressed,

  });



  final bool isFavorite;


  final VoidCallback? onPressed;



  @override
  State<FavoriteButton> createState() =>
      _FavoriteButtonState();


}







class _FavoriteButtonState
    extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {



  late AnimationController _controller;


  late Animation<double> _scaleAnimation;





  @override
  void initState() {

    super.initState();



    _controller = AnimationController(


      duration:

      const Duration(milliseconds: 200),


      vsync: this,


    );



    _scaleAnimation = Tween<double>(


      begin: 1.0,


      end: 1.3,


    ).animate(

      CurvedAnimation(

        parent: _controller,


        curve: Curves.easeOut,


      ),

    );


  }





  @override
  void dispose() {


    _controller.dispose();


    super.dispose();

  }







  void _onTap(){


    _controller.forward().then((_) {


      _controller.reverse();


    });



    if(widget.onPressed != null){

      widget.onPressed!();

    }


  }







  @override
  Widget build(BuildContext context) {


    return ScaleTransition(


      scale: _scaleAnimation,



      child: InkWell(


        onTap: _onTap,



        borderRadius:

        BorderRadius.circular(30),




        child: Container(


          padding:

          const EdgeInsets.all(6),




          decoration:

          BoxDecoration(


            color:

            Colors.black45,



            shape:

            BoxShape.circle,


          ),





          child: AnimatedSwitcher(


            duration:

            const Duration(

              milliseconds: 250,

            ),





            child: Icon(


              key: ValueKey(

                  widget.isFavorite

              ),



              widget.isFavorite

                  ? Icons.favorite

                  : Icons.favorite_border,




              color:

              widget.isFavorite

                  ? Colors.red

                  : Colors.white,



              size: 24,



            ),


          ),



        ),


      ),


    );


  }


}