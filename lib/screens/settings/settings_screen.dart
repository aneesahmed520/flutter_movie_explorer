import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../providers/theme_provider.dart';





class SettingsScreen extends StatefulWidget {


  const SettingsScreen({

    super.key,

  });



  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();


}







class _SettingsScreenState
    extends State<SettingsScreen> {





//--------------------------------------------------------------
// Build
//--------------------------------------------------------------


@override
Widget build(BuildContext context) {


return Scaffold(


appBar: AppBar(


title: const Text(
'Settings',
),


),



body: Consumer<ThemeProvider>(


builder: (

context,

themeProvider,

child,

) {


return ListView(


padding:
const EdgeInsets.all(16),



children: [



//------------------------------------------------------
// Theme Section
//------------------------------------------------------


const Text(

'Appearance',

style:
TextStyle(

fontSize: 20,

fontWeight:
FontWeight.bold,

),

),



const SizedBox(

height: 12,

),



Card(


child: SwitchListTile(


title:
const Text(
'Dark Mode',
),



subtitle:
Text(

themeProvider.isDarkMode

? 'Dark theme enabled'

: 'Light theme enabled',

),




value:
themeProvider.isDarkMode,




onChanged:
(value) async {


await themeProvider
.setTheme(
value,
);


},



),


),

  //------------------------------------------------------
  // App Information
  //------------------------------------------------------


  const SizedBox(

    height: 24,

  ),




  const Text(

    'About',

    style:
    TextStyle(

      fontSize: 20,

      fontWeight:
      FontWeight.bold,

    ),

  ),





  const SizedBox(

    height: 12,

  ),





  Card(


    child: ListTile(


      leading:
      const Icon(

        Icons.movie,

      ),




      title:
      const Text(

        'Movie Explorer',

      ),




      subtitle:
      const Text(

        'Discover movies, ratings and trailers',

      ),



    ),


  ),






  Card(


    child: ListTile(


      leading:
      const Icon(

        Icons.info_outline,

      ),




      title:
      const Text(

        'Version',

      ),




      subtitle:
      const Text(

        '1.0.0',

      ),



    ),


  ),




],


);


},


),


);


}


}