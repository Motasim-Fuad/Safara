import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:safara/Screen/HomeScreen.dart';
import 'package:safara/Screen/PhoneNumberAuth/loginWithPhone.dart';
import 'package:safara/Screen/SingupScreen.dart';
import 'package:safara/Widgets/RoundedButton.dart';
import '../Widgets/circulerIconBtn.dart';

class LoginScreen extends StatefulWidget {
  static const ro="Login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final txEmail = TextEditingController();
  final txPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    txEmail.dispose();
    txPassword.dispose();
    super.dispose();
  }



  // Google Auth Start
  Future<void> _singInWithGoogle() async{
    final GoogleSignIn googleSignIn =GoogleSignIn();

    try{
      final GoogleSignInAccount ? googleSingInAccount=await googleSignIn.signIn();
      if (googleSingInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleSingInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pushNamed(HomeScreen.ro);
      }

    }catch(e){
      debugPrint(e.toString());
      var sn =SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(sn);

      debugPrint("google auth error is :$e",);
    }
  }
  // Google auth end




//Email /Password auth
  void login() {
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
      email: txEmail.text.trim(),
      password: txPassword.text.trim(),
    )
        .then((value) {
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome ${value.user!.email}")),
      );

      Navigator.of(context).pushNamed(HomeScreen.ro);

      txEmail.clear();
      txPassword.clear();
    }).onError((error, stackTrace) {
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset("assets/logo.png", height: 300),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: txEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: "example@email.com",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: txPassword,
                      obscureText: _obscureText,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Your secure password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter your password";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Roundedbutton(
                title: "Login",
                loading: loading,
                ontap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),

              const SizedBox(height: 15),
              Text("If you don't have account please go sing up !",style: TextStyle(color: Colors.blue),),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {

                  Navigator.of(context).pushNamed(Singupscreen.ro);
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 10),

              Text("or",style: TextStyle(color: Colors.grey),),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularIconButton(
                    icon: FontAwesomeIcons.phone,
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.of(context).pushNamed(Loginwithphone.ro);
                      print("Phone login");
                    },
                  ),
                  const SizedBox(width: 12),
                  CircularIconButton(
                    icon: FontAwesomeIcons.google,
                    iconColor: Colors.deepOrange,
                    onTap: _singInWithGoogle,
                  ),
                  const SizedBox(width: 12),
                  CircularIconButton(
                    icon: FontAwesomeIcons.apple,
                    iconColor: Colors.black,
                    onTap: () {
                      var sn= SnackBar(content: Text("We are working on it. Don't worry !"));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                      print("Apple login");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
