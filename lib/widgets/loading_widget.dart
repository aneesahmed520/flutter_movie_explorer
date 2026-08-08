import 'package:flutter/material.dart';


/// ===============================================================
/// Loading Widget
/// ===============================================================
///
/// Reusable loading indicator.
///
/// Used in:
///
/// • Home Screen
/// • Search Screen
/// • Details Screen
///
/// ===============================================================


class LoadingWidget extends StatelessWidget {


  const LoadingWidget({

    super.key,

  });



  @override
  Widget build(BuildContext context) {


    return const Center(

      child: CircularProgressIndicator(),

    );


  }


}