import 'package:flutter/material.dart';
import '../utils/utils.dart';

class WrongRouteScreen extends StatelessWidget {
  const WrongRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Page not found!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            24.gapV,
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
                foregroundColor: Colors.red,
              ),
              child: const Text('Go Home'),
            )
          ],
        ),
      ),
    );
  }
}
