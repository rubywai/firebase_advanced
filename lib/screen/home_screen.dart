import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home screen'),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Dialog Screen');
                        return Material(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Dialog Screen'),
                          ),
                        );
                      });
                },
                child: const Text('Show Dialog'))
          ],
        )
      ),
    );
  }
}
