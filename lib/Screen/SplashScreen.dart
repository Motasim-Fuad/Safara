import 'package:flutter/material.dart';


import '../FirebaseServices/SplashServices.dart';

class SplashScreen extends StatefulWidget {
  static const ro="Splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
SplashServices _splashServices=SplashServices();
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _splashServices.isLogin(context);
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png",height: 400,),

                  SizedBox(height: 30,),
                  Text("TRAVEL BOOK & HIRE",style: TextStyle(fontSize: 10),),
                  SizedBox(height: 10,),
                  Text("E X P L O R E",style: TextStyle(color: Colors.yellow, fontSize: 30,fontWeight: FontWeight.bold),),
                  Text("THE UNSEEN",style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),),

                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.04,),
          SizedBox(height: 30,),
          TextButton(onPressed: (){

          }, child: Text("Swipe >>",style: TextStyle(color: Colors.grey),)),
        ],

      ),
    );
  }
}
