import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

Color getColor(int lives) {
  return lives > 3 ? Colors.green : Colors.red;
}
