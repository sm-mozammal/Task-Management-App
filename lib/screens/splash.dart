import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login.dart';
import '../utils/user_data.dart';
import '../widgets/BackgroundImage.dart';
import 'main_home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}





class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      gotoLoginScreen();
    });
  }

  void gotoLoginScreen()async{
    final shapref = await SharedPreferences.getInstance();
    final String? result = shapref.getString('token');
    if(result != null){
      UserData.token = result;
      UserData.firstName = shapref.getString("firstName");
      UserData.firstName = shapref.getString("lastName");
      UserData.firstName = shapref.getString("email");

      Future.delayed(Duration(seconds: 2)).then((value) => {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => MainHome()),
                (route) => false)
      });
    }else{
      Future.delayed(Duration(seconds: 2)).then((value) => {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false)
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child:  Center(
          child: SvgPicture.asset('assets/images/logo.svg',fit: BoxFit.scaleDown,),
        ),
      )
    );
  }
}
