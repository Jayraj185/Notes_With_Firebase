import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offNamed('Home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: Get.width/2),
                child: Text("Note Keeper",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.sp),),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: Get.height/6,
                width: Get.height/6,
                alignment: Alignment.center,
                child: Image.asset("assets/image/note_logo.png",fit: BoxFit.fill,),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/6),
                child: Text(" From",style: TextStyle(color: Colors.grey, fontSize: 12.sp),),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/9),
                child: Text("Jayraj",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/3.3),
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
