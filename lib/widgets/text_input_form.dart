import 'package:flutter/material.dart';

class TextInputForm extends StatefulWidget {
  final double width;
  final String hint;
  final TextEditingController controller;
  final bool hideText;
  const TextInputForm({
    super.key,
    required this.width,
    required this.hint,
    required this.controller,
    this.hideText = false,
  });

  @override
  State<TextInputForm> createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm> {
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder boder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide:
            BorderSide(width: 2, color: Theme.of(context).colorScheme.primary));
    return SizedBox(
      width: widget.width,
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            obscureText: widget.hideText ? _obscured : false,
            controller: widget.controller,
            cursorColor: Theme.of(context).colorScheme.primary,
            decoration: InputDecoration(
              enabledBorder: boder,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: boder,
              focusColor: Theme.of(context).colorScheme.primary,
              hintText: widget.hint,
              hintStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          if (widget.hideText)
            IconButton(
              icon: Icon(
                _obscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _toggleObscured,
            ),
        ],
      ),
    );
  }
}
