import 'package:flutter/material.dart';

class SecretTextform extends StatefulWidget {
  const SecretTextform(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.fKey,
      required this.controller_parent});
  final String labelText;
  final TextEditingController controller;
  final GlobalKey<FormState> fKey;
  final TextEditingController? controller_parent;
  @override
  State<SecretTextform> createState() => _SecretTextformState();
}

class _SecretTextformState extends State<SecretTextform> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.fKey,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: TextFormField(
          obscureText: obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            labelText: widget.labelText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "please , Enter ${widget.labelText}";
            }
            if (widget.labelText == "Confirm Password" &&
                widget.controller_parent != null) {
              if (val != widget.controller_parent!.text) {
                return "Password does not match";
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
