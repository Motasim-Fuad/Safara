import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screen/GetStartScreen.dart';
import '../Screen/HomeScreen.dart';


class SplashServices{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3), ()=>Navigator.of(context).pushNamed(HomeScreen.ro) );
    }else{
      Timer(const Duration(seconds: 3), ()=>Navigator.of(context).pushNamed(GetstartScreen.ro)  );
    }

  }
}