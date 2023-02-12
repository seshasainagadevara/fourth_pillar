import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fourth_pillar/app_constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final IconData icon;
  final bool hideText;

  const TextInputField(
      {super.key,
      required this.textEditingController,
      required this.label,
      required this.icon,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 20),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: teritaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: teritaryColor),
        ),
      ),
      obscureText: hideText,
    );
  }
}
