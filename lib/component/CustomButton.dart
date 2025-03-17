import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
   Custombutton({super.key, required this.action, required this.onTap});
final String action;
final VoidCallback onTap;

   @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap:onTap,


      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child:  Center(child: Text(action)),

      ),
    );
  }
}
