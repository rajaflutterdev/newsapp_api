import 'package:flutter/material.dart';
import 'package:newsapp_api/splash%20Screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.



  // Use ChangeNotifierProvider from Provider package if
  @override
  Widget build(BuildContext context) {

    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  splahScreen(),
    );
  }
}







