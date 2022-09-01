import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shedule_app/Screens/homescreen.dart';
import 'package:shedule_app/Screens/loginscreen.dart';
import 'package:shedule_app/Utils/PrefConsts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final prefs;

  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();

    init();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => prefs!.getBool(PrefConsts.isLogin)!= null && prefs!.getBool(PrefConsts.isLogin)!  ? HomeScreen() : LoginScreen()
            ));

      };
  });

        }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/img/logo.png" , width: 130, height: 150,),
          ],
        ),
      ),
    );
  }

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
