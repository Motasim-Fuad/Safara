import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safara/Screen/HomeScreen.dart';
import 'package:safara/Widgets/RoundedButton.dart';

class VeryfiyCode extends StatefulWidget {
  final String verificationId;
  const VeryfiyCode({super.key, required this.verificationId});

  @override
  State<VeryfiyCode> createState() => _VeryfiyCodeState();
}

class _VeryfiyCodeState extends State<VeryfiyCode> {
  final code = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  void _verifyCode() async {
    setState(() => loading = true);

    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: code.text.trim(),
    );

    try {
      await _auth.signInWithCredential(credential);
      Navigator.of(context).pushReplacementNamed(HomeScreen.ro);
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error verifying code: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Verification Code")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: code,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                hintText: "Enter the SMS code",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 20),
            Roundedbutton(
              title: "Verify Code",
              loading: loading,
              ontap: _verifyCode,
            ),
          ],
        ),
      ),
    );
  }
}
