import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterappnavigation/button_login.dart';
import 'package:flutterappnavigation/constan.dart';
import 'package:flutterappnavigation/main.dart';
import 'package:flutterappnavigation/services/services.dart';
import 'package:get/get.dart';

class AddBlocRangIP extends StatefulWidget {
  @override
  _AddBlocRangIPState createState() => _AddBlocRangIPState();
}
class _AddBlocRangIPState extends State<AddBlocRangIP> {
  var formKey=GlobalKey<FormState>();
  var  first_point=TextEditingController();
  var  secound=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add Point',style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 18,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter First Point',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value){
                  if(value==null){
                    return "You shold Enter  Api Key" ;
                  }
                  return null;
                },
                controller: first_point,
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Second Point',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value){
                  if(value==null){
                    return "You shold Enter  Api Key" ;
                  }
                  return null;
                },
                controller: secound,
              ),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
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
                      var dis1=double.parse(first_point.text)!=null?double.parse(first_point.text):50.0;
                      if(distance>50&&distance<70){
                        Constant.constant.mynewshape.add(Constant.constant.listShapeLatLng[i]);
                        x=i;
                        break;
                      }
                    }

                  }
                  setState(() {
                  }

                  );
                  Get.off(
                    MapPage(),
                  );
                },
                child: ButtonLogin('Add'),
              ),
            ],
          ),
        )
    );
  }
}
