import 'package:flutter/material.dart';


/// ===============================================================
/// Search Bar Widget
///
/// Features:
///
/// • Search input
/// • Search icon
/// • Clear button
/// • Material 3 style
///
/// ===============================================================


class SearchBarWidget extends StatefulWidget {


  const SearchBarWidget({

    super.key,

    required this.controller,

    this.onChanged,

    this.hintText = 'Search movies...',


  });



  final TextEditingController controller;


  final ValueChanged<String>? onChanged;


  final String hintText;



  @override
  State<SearchBarWidget> createState() =>
      _SearchBarWidgetState();


}







class _SearchBarWidgetState
    extends State<SearchBarWidget> {





  @override
  void initState() {

    super.initState();


    widget.controller.addListener(_onControllerChanged);


  }







  void _onControllerChanged(){


    setState(() {});


  }







  @override
  void dispose() {


    widget.controller.removeListener(
        _onControllerChanged
    );


    super.dispose();


  }








  void _clearSearch(){


    widget.controller.clear();



    if(widget.onChanged != null){


      widget.onChanged!('');

    }


  }









  @override
  Widget build(BuildContext context) {


    return Padding(


      padding:

      const EdgeInsets.all(16),





      child: TextField(


        controller:

        widget.controller,




        onChanged:

        widget.onChanged,





        textInputAction:

        TextInputAction.search,





        decoration:

        InputDecoration(




          hintText:

          widget.hintText,





          prefixIcon:

          const Icon(

            Icons.search,

          ),





          suffixIcon:

          widget.controller.text.isNotEmpty



              ? IconButton(


            onPressed:

            _clearSearch,



            icon:

            const Icon(

              Icons.clear,

            ),



          )



              : null,







          filled:

          true,



          fillColor:

          Theme.of(context)

              .colorScheme

              .surfaceContainerHighest,







          border:

          OutlineInputBorder(



            borderRadius:

            BorderRadius.circular(16),




            borderSide:

            BorderSide.none,



          ),



        ),



      ),



    );


  }



}