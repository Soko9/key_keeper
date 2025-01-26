import 'dart:math';

import 'package:flutter/material.dart';

class Meter extends StatelessWidget {
  final int score;
  final bool isConstant;

  const Meter({
    super.key,
    required this.score,
    this.isConstant = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    final widget = switch (isConstant) {
      true => Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size.width * 0.6,
                height: size.width * 0.6,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeCap: StrokeCap.butt,
                  strokeWidth: 24.0,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                height: size.width * 0.5,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeCap: StrokeCap.butt,
                  strokeWidth: 18.0,
                  color: theme.colorScheme.primary.withValues(alpha: 0.6),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 78.0,
                      height: 1.0,
                      fontWeight: FontWeight.bold,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                  Text(
                    score != 1 ? 'notes' : 'note',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      false => Center(
          child: Transform.rotate(
            angle: -pi / 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeCap: StrokeCap.butt,
                    strokeWidth: 24.0,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.width * 0.5,
                  child: CircularProgressIndicator(
                    value: score / 100 * 1.25,
                    strokeCap: StrokeCap.butt,
                    strokeWidth: 18.0,
                    color: theme.colorScheme.primary.withValues(alpha: 0.6),
                  ),
                ),
                Transform.rotate(
                  angle: pi / 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$score',
                        style: TextStyle(
                          fontSize: 78.0,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                      Text(
                        'score',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    };

    return widget;
  }
}
