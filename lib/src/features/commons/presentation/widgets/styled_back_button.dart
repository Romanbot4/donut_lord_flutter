import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const StyledBackButton({super.key, this.onPressed});

  static const _size = 40.0;
  static const _iconSize = 24.0;

  void _back(BuildContext context) {
    final router = GoRouter.of(context);
    router.canPop() ? router.pop() : router.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: MaterialLocalizations.of(context).backButtonTooltip,
      child: GestureDetector(
        onTap: onPressed ?? () => _back(context),
        child: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            size: _iconSize,
            color: context.textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
