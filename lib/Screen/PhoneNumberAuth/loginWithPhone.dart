import 'package:flutter/material.dart';

class Loginwithphone extends StatefulWidget {
  const Loginwithphone({super.key});

  @override
  State<Loginwithphone> createState() => _LoginwithphoneState();
}

class _LoginwithphoneState extends State<Loginwithphone> {

  final _numbercontroler= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        centerTitle: true,
        title: Text("Login With Your Phone Number"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _numbercontroler,
            )
          ],
        ),
      ),
    ) ;
  }
}
