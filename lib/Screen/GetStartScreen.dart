import 'package:flutter/material.dart';

import 'package:safara/Screen/LoginScreen.dart';
import '../Widgets/dot.dart';


class GetstartScreen extends StatefulWidget {
  static const ro="Start";
  const GetstartScreen({super.key});

  @override
  State<GetstartScreen> createState() => _GetstartScreenState();
}

class _GetstartScreenState extends State<GetstartScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/image.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Discover the world with Safara.\n\nPlan, book, and explore your dream destinations effortlessly. From hidden gems to top attractions, we've got it all covered.\n\nStart your journey with Safara today!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginScreen.ro);

                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.yellow, Colors.deepOrange],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Dot(active: false),
                SizedBox(width: 12),
                Dot(active: false),
                SizedBox(width: 12),
                Dot(active: true),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
