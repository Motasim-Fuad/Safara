import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safara/Screen/HomeScreen.dart';
import 'package:safara/Widgets/RoundedButton.dart';

class VeryfiyCode extends StatefulWidget {
  final String verificationId;
  const VeryfiyCode({super.key,required this.verificationId});

  @override
  State<VeryfiyCode> createState() => _VeryfiyCodeState();
}

class _VeryfiyCodeState extends State<VeryfiyCode> {

  final code= TextEditingController();
  bool loading=false;
  final _auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller:code ,
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
              title: "code",
              loading: loading,
              ontap: ()async{
                setState(() {
                  loading=true;
                });

                final credentialToken = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: code.text.toString(),
                );

                try{
                  await _auth.signInWithCredential(credentialToken);
                  Navigator.of(context).pushNamed(HomeScreen.ro);

                }catch(e){
                  setState(() {
                    loading=false;
                  });
                  var sn= SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                }

              }
          )

        ],
      ),
    );
  }
}
