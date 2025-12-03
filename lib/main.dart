import 'package:flutter/material.dart';
import 'splash_screen.dart';

const kMainColor = Color(0xFF009688);

void main() => runApp(const MedFinderApp());

class MedFinderApp extends StatelessWidget {
  const MedFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primaryColor: kMainColor),
      home: const SplashScreen(),
    );
  }
}
