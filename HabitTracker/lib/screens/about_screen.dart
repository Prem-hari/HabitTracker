import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About this app'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Habit Tracker\n\n'
          'A simple app to help you build daily habits and keep track of your streaks.',
        ),
      ),
    );
  }
}
