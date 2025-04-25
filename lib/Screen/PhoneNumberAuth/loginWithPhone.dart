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
  final _numberController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _startPhoneAuth() {
    final phoneNumber = _numberController.text.trim();

    if (!phoneNumber.startsWith('+')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone number must start with '+' and country code")),
      );
      return;
    }

    setState(() => loading = true);

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) => setState(() => loading = false),
      verificationFailed: (e) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() => loading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VeryfiyCode(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Code auto-retrieval timeout")),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        centerTitle: true,
        title: Text("Login With Your Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                hintText: "Enter your phone number with country code",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 20),
            Roundedbutton(
              title: "Send Code",
              loading: loading,
              ontap: _startPhoneAuth,
            ),
          ],
        ),
      ),
    );
  }
}
