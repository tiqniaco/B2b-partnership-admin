import 'package:flutter/material.dart';

class PlatformsModel {
  final String title;
  final Widget icon;
  final Function onTab;

  PlatformsModel({
    required this.title,
    required this.icon,
    required this.onTab,
  });
}
