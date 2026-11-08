import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;

  const StyledTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.prefix,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: color),
    );

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.textTheme.bodyLarge?.copyWith(color: AppColors.grey),
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(),
        filled: true,
        fillColor: context.theme.cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppInsets.sm,
          vertical: AppInsets.sm,
        ),
        border: border(AppColors.transparent),
        enabledBorder: border(AppColors.transparent),
        focusedBorder: border(colors.primary),
        errorBorder: border(colors.error),
        focusedErrorBorder: border(colors.error),
        errorMaxLines: 2,
      ),
    );
  }
}
