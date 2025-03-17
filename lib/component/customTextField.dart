import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Customtextfield extends StatelessWidget {

   Customtextfield({super.key, required this.hintText,this.onChange,  this.obsec=false});


   final String hintText;
   final bool? obsec;
Function (String)? onChange;



  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obsec!,
validator: (data){
  if(data!.isEmpty)
    {
      return 'data is require ';
    }
},
      onChanged:onChange,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
      ),
    );
  }
}
