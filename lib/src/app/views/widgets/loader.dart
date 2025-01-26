import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 0.25,
            child: CircularProgressIndicator(
              color: primary.withValues(alpha: 0.25),
              strokeWidth: 1.5,
              strokeCap: StrokeCap.round,
            ),
          ),
          Transform.scale(
            scale: 0.5,
            child: CircularProgressIndicator(
              color: primary.withValues(alpha: 0.5),
              strokeWidth: 1.5,
              strokeCap: StrokeCap.round,
            ),
          ),
          Transform.scale(
            scale: 0.75,
            child: CircularProgressIndicator(
              color: primary.withValues(alpha: 0.75),
              strokeWidth: 1.5,
              strokeCap: StrokeCap.round,
            ),
          ),
          CircularProgressIndicator(
            color: primary,
            strokeWidth: 1.5,
            strokeCap: StrokeCap.round,
          ),
        ],
      ),
    );
  }
}
