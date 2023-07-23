import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefix,
    required this.function,
  });

  final TextEditingController controller;
  final String label;
  final String prefix;
  final Function(String)? function;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: function,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.amber,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
            width: 2,
          ),
        ),
        prefixText: "$prefix ",
        prefixStyle: const TextStyle(
          color: Colors.amber,
          fontSize: 20,
        ),
      ),
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 20,
      ),
    );
  }
}
