import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

/// Phone input with the fixed "+95" prefix.
class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return StyledTextField(
      controller: controller,
      autofocus: true,
      hintText: context.localizations.lblEnterPhone,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      prefix: Padding(
        padding: const EdgeInsets.only(
          left: AppInsets.sm,
          right: AppInsets.xs,
        ),
        child: Text(
          PhoneNumberValidator.countryCode,
          style: context.textTheme.bodyLarge?.copyWith(color: AppColors.grey),
        ),
      ),
    );
  }
}
