import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safara/Screen/HomeScreen.dart';
import 'package:safara/Widgets/RoundedButton.dart';

class Singupscreen extends StatefulWidget {
  static const ro="Sing_up";
  const Singupscreen({super.key});

  @override
  State<Singupscreen> createState() => _SingupscreenState();
}

class _SingupscreenState extends State<Singupscreen> {
  bool _obscureText = true;
  bool loading = false;
  final _fromkey = GlobalKey<FormState>();

  final txEmail = TextEditingController();
  final txPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    txEmail.dispose();
    txPassword.dispose();
  }

  void singUp() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
      email: txEmail.text.trim(),
      password: txPassword.text.trim(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });

      // Clear only after success
      txEmail.clear();
      txPassword.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful: ${value.user?.email ?? ''}')),
      );
      Navigator.of(context).pushNamed(HomeScreen.ro);

    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset("assets/logo.png", height: 400),
            const Text("Add your data!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
            Form(
              key: _fromkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: txEmail,
                    decoration: const InputDecoration(
                      hintText: "email",
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter email";
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
                      hintText: "Password",
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.password_outlined),
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
                        return "Enter password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Roundedbutton(
              title: "Sign Up",
              loading: loading,
              ontap: () {
                if (_fromkey.currentState!.validate()) {
                  singUp();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
