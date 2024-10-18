import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'NewsScreen.dart';
import 'const.dart';

class splahScreen extends StatefulWidget {
  const splahScreen({super.key});

  @override
  State<splahScreen> createState() => _splahScreenState();
}

class _splahScreenState extends State<splahScreen> {


  @override
  void initState() {
    Future.delayed( const Duration(seconds: 5),(){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const textScreen()), (Route<dynamic> route) => false);
//      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  const signinScreen(),(Route<dynamic> route) => false));
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Container(
        height:
        mediaQueryClass.height(inputValue: 0.9,context: context),
        width:
        mediaQueryClass.width(inputValue: 0.9,context: context),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(appBackgroungimg))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: mediaQueryClass.height(inputValue: 3,context: context)),
              child: Image.asset(appLogo,height: mediaQueryClass.height(inputValue: 2.5,context: context),
                width: mediaQueryClass.width(inputValue: 2.5,context: context),fit: BoxFit.contain,),
            ),
            Padding(
              padding:  EdgeInsets.only(top:mediaQueryClass.height(inputValue: 10,context: context)),
              child: Lottie.asset(loadingLottie.toString(),height: mediaQueryClass.height(inputValue: 10,context: context),
                  width: mediaQueryClass.width(inputValue: 5,context: context)),
            ),
            Text("Loading",style:GoogleFonts.actor(fontSize: mediaQueryClass.width(context: context,
                inputValue:20),fontWeight: FontWeight.w900),),

          ],
        ),
      ),
    );
  }
}
