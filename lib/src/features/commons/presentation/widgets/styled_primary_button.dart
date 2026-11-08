import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isEnabled;

  const StyledPrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  State<StyledPrimaryButton> createState() => _StyledPrimaryButtonState();
}

class _StyledPrimaryButtonState extends State<StyledPrimaryButton> {
  static const _height = 48.0;
  static const _spinnerSize = 20.0;
  static const _spinnerStroke = 2.5;

  bool _pressed = false;

  bool get _isActive =>
      widget.isEnabled && !widget.isLoading && widget.onTap != null;

  void _setPressed(bool value) {
    if (_isActive && _pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final background = widget.isEnabled
        ? colors.secondary
        : AppColors.neutral200;

    return GestureDetector(
      onTap: _isActive ? widget.onTap : null,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? AppMotion.pressedScale : 1,
        duration: AppMotion.fast,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          height: _height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          child: AnimatedSwitcher(
            duration: AppMotion.fast,
            child: widget.isLoading
                ? SizedBox.square(
                    key: const ValueKey(true),
                    dimension: _spinnerSize,
                    child: CircularProgressIndicator(
                      strokeWidth: _spinnerStroke,
                      color: colors.onSecondary,
                    ),
                  )
                : Text(
                    widget.label.toUpperCase(),
                    key: const ValueKey(false),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: colors.onSecondary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
