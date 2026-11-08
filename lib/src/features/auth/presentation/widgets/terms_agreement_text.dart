import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class TermsAgreementText extends StatelessWidget {
  const TermsAgreementText({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final style = context.textTheme.bodySmall;
    final linkStyle = style?.copyWith(color: context.theme.colorScheme.primary);
    void comingSoon() => Snacks.info(context, message: strings.lblComingSoon);

    return Text.rich(
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
      TextSpan(
        text: strings.lblAgreementPart1,
        style: style,
        children: [
          TextSpan(
            text: strings.lblTermsOfService,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = comingSoon,
          ),
          TextSpan(text: strings.lblAnd),
          TextSpan(
            text: strings.lblPrivacyPolicy,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = comingSoon,
          ),
          TextSpan(text: strings.lblAgreementPart2),
        ],
      ),
    );
  }
}
