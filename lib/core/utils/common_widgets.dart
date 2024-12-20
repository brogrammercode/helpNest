import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final bool isEnabled;
  final TextInputType keyboardType;

  const CustomTextFormField({
    required this.labelText,
    this.hintText,
    required this.controller,
    this.maxLines,
    this.minLines,
    this.isEnabled = true,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      enabled: isEnabled,
      keyboardType: keyboardType,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
