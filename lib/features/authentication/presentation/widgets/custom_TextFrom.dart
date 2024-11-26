import 'package:flutter/material.dart';

class CustomTextfrom extends StatelessWidget {
  const CustomTextfrom(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.fKey});
  final String labelText;
  final TextEditingController controller;
  final GlobalKey<FormState> fKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: fKey,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            labelText: labelText,
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "please , Enter $labelText";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
