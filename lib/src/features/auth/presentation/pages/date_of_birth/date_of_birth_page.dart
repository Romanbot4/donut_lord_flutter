import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class DateOfBirthPage extends StatelessWidget {
  const DateOfBirthPage({super.key});

  static const String routePath = "/date-of-birth";

  static const _dayDigits = 2;
  static const _yearDigits = 4;

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final cubit = context.read<DateOfBirthCubit>();
    final (isValid, isSubmitting) = context.select(
      (DateOfBirthCubit cubit) =>
          (cubit.state.isValid, cubit.state.isSubmitting),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<DateOfBirthCubit, DateOfBirthState>(
          listenWhen: (previous, current) =>
              !previous.isSaved && current.isSaved,
          // Registration is complete: replace the steps so Back can't return.
          listener: (context, _) => context.go(WelcomePage.routePath),
        ),
        BlocListener<DateOfBirthCubit, DateOfBirthState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) =>
              Snacks.error(context, message: state.failure!.message),
        ),
      ],
      child: AuthStepLayout(
        step: AuthStepLayout.totalSteps,
        isComplete: isValid,
        title: strings.lblWhatsYourDateOfBirth,
        body: Column(
          spacing: AppSpacing.xs,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _MonthField(),
            StyledTextField(
              hintText: strings.lblDay,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(_dayDigits),
              ],
              onChanged: cubit.onDayChanged,
            ),
            StyledTextField(
              hintText: strings.lblYear,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(_yearDigits),
              ],
              onChanged: cubit.onYearChanged,
              onFieldSubmitted: (_) => cubit.submit(),
            ),
            const _DateErrorMessage(),
          ],
        ),
        button: StyledPrimaryButton(
          label: strings.btnContinue,
          isEnabled: isValid,
          isLoading: isSubmitting,
          onTap: cubit.submit,
        ),
      ),
    );
  }
}

class _MonthField extends StatelessWidget {
  const _MonthField();

  static const _monthsInYear = 12;
  static const _anyYear = 2000;

  String _monthName(BuildContext context, int month) =>
      DateFormat.MMMM(context.localizations.localeName)
          .format(DateTime(_anyYear, month));

  Future<void> _pickMonth(BuildContext context) async {
    final cubit = context.read<DateOfBirthCubit>();
    final month = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _monthsInYear,
          itemBuilder: (sheetContext, index) => ListTile(
            title: Text(_monthName(context, index + 1)),
            selected: cubit.state.month == index + 1,
            onTap: () => Navigator.of(sheetContext).pop(index + 1),
          ),
        ),
      ),
    );
    if (month != null) cubit.onMonthChanged(month);
  }

  @override
  Widget build(BuildContext context) {
    final month = context.select((DateOfBirthCubit cubit) => cubit.state.month);
    final style = context.textTheme.bodyLarge;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _pickMonth(context),
      child: Container(
        padding: const EdgeInsets.all(AppInsets.sm),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(
          month == null
              ? context.localizations.lblMonth
              : _monthName(context, month),
          style: month == null ? style?.copyWith(color: AppColors.grey) : style,
        ),
      ),
    );
  }
}

class _DateErrorMessage extends StatelessWidget {
  const _DateErrorMessage();

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final error = context.select(
      (DateOfBirthCubit cubit) => cubit.state.visibleError,
    );
    final message = switch (error) {
      null || DateOfBirthError.incomplete => null,
      DateOfBirthError.invalidDate => strings.lblDateOfBirthInvalid,
      DateOfBirthError.inFuture => strings.lblDateOfBirthInFuture,
      DateOfBirthError.tooYoung => strings.lblDateOfBirthTooYoung(
        DateOfBirthValidator.minimumAge,
      ),
    };

    return AnimatedSize(
      duration: AppMotion.fast,
      alignment: Alignment.topLeft,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : Text(
              message,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.theme.colorScheme.error,
              ),
            ),
    );
  }
}
