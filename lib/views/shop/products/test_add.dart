import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart'; // import without alias

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});
  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  late final QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rich Text Editor')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            QuillSimpleToolbar(
              controller: _controller,
              config: const QuillSimpleToolbarConfig(
                  showSearchButton: false,
                  showLink: false,
                  showCodeBlock: false,
                  showAlignmentButtons: true),
            ),
            Expanded(
              child: QuillEditor.basic(
                controller: _controller,
                config: const QuillEditorConfig(),
              ),
            ),

            // مثال: زر لتحويل المحتوى إلى JSON (Delta) وعرضه
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final delta = _controller.document.toDelta();
                  final jsonString = jsonEncode(delta.toJson());
                  // هنا تبعتي jsonString للـ API أو تحفظيه في DB
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delta (JSON)'),
                      content: SingleChildScrollView(child: Text(jsonString)),
                    ),
                  );
                },
                child: const Text('Show Delta JSON'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
