import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    100 + random.nextInt(156),
    100 + random.nextInt(156),
    100 + random.nextInt(156),
    1,
  );
}
