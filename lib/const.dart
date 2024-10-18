
import 'package:flutter/cupertino.dart';

String loadingLottie="assets/aGerGSeEbn.json";
String appLogo="assets/News Mic.png";
String appBackgroungimg="assets/appBackground.png";


class mediaQueryClass{


  static height({inputValue,context}){
    double deviceHeight=MediaQuery.of(context).size.height;
    double  result=deviceHeight/inputValue;
   print(deviceHeight);
   print(inputValue);
   print(result);
    return  result;

  }
  static width({inputValue,context}){
    double deviceWidth=MediaQuery.of(context).size.width;
    double  result=deviceWidth/inputValue;
    print(deviceWidth);
    print(inputValue);
    print(result);
    return  result;

  }


}

