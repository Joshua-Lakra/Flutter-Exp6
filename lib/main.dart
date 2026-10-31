
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool isLarge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: isLarge ? 300 : 150,
              height: isLarge ? 300 : 150,
              decoration: BoxDecoration(
                color: isLarge ? Colors.orange : Colors.blue,
                borderRadius: BorderRadius.circular(
                  isLarge ? 50 : 20,
                ),
              ),
              child: const Center(
                child: Text(
                  'Flutter',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLarge = !isLarge;
                });
              },
              child: const Text('Animate'),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation,
                        secondaryAnimation) {
                      return const SecondPage();
                    },
                    transitionsBuilder: (context, animation,
                        secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text('Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Page Transition Successful!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
