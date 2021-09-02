import 'package:flutter/material.dart';
import 'package:flutterappnavigation/constan.dart';

import 'main.dart';

class GetTokenScreen extends StatelessWidget {

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text('Add The Active Token',
              style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 290,
                child: TextField(
                  controller:controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'description',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),

                ),
                ),
              ),
              MaterialButton(
                onPressed: (){
                 if (controller.text.isNotEmpty) {
                   Constant.constant.TOKEN = controller.text;
                 }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPage()));
                },
                height: 35,
                child: Text('Save Token',style: TextStyle(color: Colors.white),),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
