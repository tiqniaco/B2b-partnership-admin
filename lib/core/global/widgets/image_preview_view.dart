import 'dart:io';

import 'package:flutter/material.dart';
import '/core/enums/image_type_enum.dart';

class ImagePreviewView extends StatelessWidget {
  const ImagePreviewView({
    super.key,
    required this.imageUrl,
    required this.type,
  });
  final String imageUrl;
  final ImageTypeEnum type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Preview"),
      ),
      body: Center(
        child: type == ImageTypeEnum.asset
            ? Image.asset(imageUrl, fit: BoxFit.fill)
            : type == ImageTypeEnum.network
                ? Image.network(imageUrl, fit: BoxFit.fill)
                : Image.file(File(imageUrl), fit: BoxFit.fill),
      ),
    );
  }
}
