import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {

  final String title;
  final VoidCallback ontap;
  final bool loading;

  const Roundedbutton({super.key,required this.title,required this.loading, required this.ontap});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: ontap,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Colors.yellow,
                Colors.orange
              ])
            ),
            child: Center(
              child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.green,) :Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)
            ),
          ),
    );
  }
}
