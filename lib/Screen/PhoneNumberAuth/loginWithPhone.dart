import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safara/Screen/PhoneNumberAuth/veryfiy_code.dart';
import 'package:safara/Widgets/RoundedButton.dart';

class Loginwithphone extends StatefulWidget {
  static const ro = "Phone_Number_Auth";
  const Loginwithphone({super.key});

  @override
  State<Loginwithphone> createState() => _LoginwithphoneState();
}

class _LoginwithphoneState extends State<Loginwithphone> {

  final _numbercontroler= TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading =false;
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
              controller:_numbercontroler ,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Give Your Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            Roundedbutton(
                title: "Num Login",
                loading: loading,
                ontap: (){
                  setState(() {
                    loading=true;
                  });

                  _auth.verifyPhoneNumber(
                    phoneNumber: _numbercontroler.text,
                      verificationCompleted: (_){
                      setState(() {
                        loading=false;
                      });
                      },
                      verificationFailed: (e){
                      setState(() {
                        loading=false;
                      });
                      var sn= SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                      },
                      codeSent: (String verificationId , int ? token){
                      setState(() {
                        loading=false;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>VeryfiyCode(
                        verificationId: verificationId,
                      )));
                      },
                      codeAutoRetrievalTimeout: (e){
                      setState(() {
                        loading=false;
                      });
                      var sn= SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                      }
                  );
                }
            )
          ],
        ),
      ),
    ) ;
  }
}
