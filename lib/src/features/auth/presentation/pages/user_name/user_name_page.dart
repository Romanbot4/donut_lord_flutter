import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key});

  static const String routePath = "/user-name";

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    context.read<UserNameCubit>().submit(
      firstName: _firstName.text,
      lastName: _lastName.text,
    );
  }

  String? _message(NameValidationError? error) {
    final strings = context.localizations;
    return switch (error) {
      null => null,
      NameValidationError.required => strings.lblFirstNameRequired,
      NameValidationError.tooLong => strings.lblNameTooLong(
        NameValidator.maxLength,
      ),
      NameValidationError.invalidCharacters => strings.lblNameInvalid,
    };
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;

    return BlocListener<UserNameCubit, UserNameState>(
      listener: (context, state) => switch (state) {
        // Pushed, so Back returns here with the name still filled in.
        UserNameSaved() => context.push(DateOfBirthPage.routePath),
        UserNameFailed(:final failure) => Snacks.error(
          context,
          message: failure.message,
        ),
        _ => null,
      },
      child: AuthStepLayout(
        step: 3,
        title: strings.lblWhatsYourName,
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            spacing: AppSpacing.xs,
            children: [
              StyledTextField(
                autofocus: true,
                controller: _firstName,
                hintText: strings.lblFirstName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    _message(NameValidator.validateFirstName(value)),
              ),
              StyledTextField(
                controller: _lastName,
                hintText: strings.lblLastName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                validator: (value) =>
                    _message(NameValidator.validateLastName(value)),
                onFieldSubmitted: (_) => _submit(),
              ),
            ],
          ),
        ),
        button: BlocSelector<UserNameCubit, UserNameState, bool>(
          selector: (state) => state is UserNameSubmitting,
          builder: (context, isSubmitting) => StyledPrimaryButton(
            label: strings.btnContinue,
            isLoading: isSubmitting,
            onTap: _submit,
          ),
        ),
      ),
    );
  }
}
