import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  static const String routePath = "/phone";

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    final phoneNumber = PhoneNumberValidator.normalize(_controller.text);
    if (phoneNumber != null) context.push(OtpPage.location(phoneNumber));
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return PhoneNumberValidator.isValid(value)
        ? null
        : context.localizations.lblEnterValidPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return AuthStepLayout(
      step: 1,
      title: context.localizations.lblEnterPhone,
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: PhoneNumberField(
          controller: _controller,
          validator: _validate,
          onFieldSubmitted: (_) => _continue(),
        ),
      ),
      button: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, _) => StyledPrimaryButton(
          label: context.localizations.btnContinue,
          isEnabled: PhoneNumberValidator.isValid(value.text),
          onTap: _continue,
        ),
      ),
    );
  }
}
