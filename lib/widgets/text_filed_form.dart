import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;
  final String? hintTxt;
  final String labelText;
  final IconButton? suffixIcon;
  final String? prefixText;
  final FocusNode? focusNode;
  final List<String>? autofillHints;
  final TextCapitalization? textCapitalization;
  final TextInputFormatter? inputFormatters;
  final Icon? prefixIcon;
  final int? maxLines;
  const InputTextFormField({
    super.key,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.labelText,
    this.hintTxt,
    this.suffixIcon,
    this.prefixText,
    this.focusNode,
    this.autofillHints,
    this.textCapitalization,
    this.prefixIcon,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      autofillHints: autofillHints,

      maxLines: maxLines ?? 1,
      textCapitalization:
          textCapitalization != null
              ? textCapitalization!
              : TextCapitalization.none,
      inputFormatters: inputFormatters != null ? [inputFormatters!] : [],
      decoration: InputDecoration(
        prefixText: prefixText != null ? prefixText! : '',
        prefixIcon: prefixIcon,
        fillColor: AppColors.main_background_color.withOpacity(0.2),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.text_color.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.text_color.withOpacity(0.2)),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value) => validator(value.toString()),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
