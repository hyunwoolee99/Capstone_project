import 'package:flutter/material.dart';

class AdvancedTextField extends StatelessWidget {
  const AdvancedTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.multiline,
    this.maxLines,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool? multiline;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: multiline == null || multiline == false
          ? null
          : TextInputType.multiline,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
