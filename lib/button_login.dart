import 'package:flutter/material.dart';
class ButtonLogin extends StatelessWidget {
  String text;
  ButtonLogin(this.text,);
  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child:Text(text,style:TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),)
      ),
    );
  }
}
