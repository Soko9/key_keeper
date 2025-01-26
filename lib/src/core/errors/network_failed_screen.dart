import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NetworkFailedScreen extends StatelessWidget {
  const NetworkFailedScreen({super.key});

  static const String routeName = '/network-failed';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24.0,
          children: [
            Stack(
              children: [
                Icon(
                  FontAwesomeIcons.wifi,
                  size: size.width * 0.15,
                  color: theme.colorScheme.error,
                ),
                Icon(
                  FontAwesomeIcons.slash,
                  size: size.width * 0.15,
                  color: theme.colorScheme.error,
                ),
              ],
            ),
            Text(
              'CHECK YOUR CONNECTION',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
