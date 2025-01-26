import 'package:flutter/material.dart';

extension NumX on num {
  SizedBox get gapV => SizedBox(height: toDouble());
  SizedBox get gapH => SizedBox(width: toDouble());
}
