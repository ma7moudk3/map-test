

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterappnavigation/get_token_screen.dart';
import 'package:flutterappnavigation/input_key.dart';
import 'package:flutterappnavigation/main.dart';
import 'package:flutterappnavigation/services/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constan.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getStationState(Get.context);
    getTop10FaildLoginState(Get.context);
    for(int x=0;x<Constant.constant.listShapeLatLng.length;){
      double distance=0.0;
      for(int i=0;i<Constant.constant.listShapeLatLng.length;i++){
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 -
            c((Constant.constant.listShapeLatLng[i].latitude - Constant.constant.listShapeLatLng[x].latitude) * p) / 2 +
            c(Constant.constant.listShapeLatLng[x].latitude * p) *
                c(Constant.constant.listShapeLatLng[i].latitude * p) *
                (1 - c((Constant.constant.listShapeLatLng[i].longitude - Constant.constant.listShapeLatLng[x].longitude) * p)) /
                2;
        distance = 12742 * asin(sqrt(a))*1000;
    //    var dis1=double.parse(first_point.text)!=null?double.parse(first_point.text):50.0;
        if(distance>50&&distance<70){
          Constant.constant.mynewshape.add(Constant.constant.listShapeLatLng[i]);
          x=i;
          break;
        }
      }

    }

  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Get.off(
        GetTokenScreen(),
      );
    });
    return Scaffold(
      body: Center(
          child:Container(
            child: Center(child: Text('Splash',style:TextStyle(
              fontSize: 22,
            ),)),
          )
      ),
    );
  }
}
