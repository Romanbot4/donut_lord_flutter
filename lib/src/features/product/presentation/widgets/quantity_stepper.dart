import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final bool canDecrement;
  final bool canIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.canDecrement,
    required this.canIncrement,
    required this.onDecrement,
    required this.onIncrement,
  });

  static const height = _tapSize + 2 * _padding;

  static const _buttonSize = 32.0;
  static const _tapSize = kMinInteractiveDimension;
  static const _padding = AppInsets.xxs;
  static const _numberWidth = 48.0;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        border: Border.all(color: context.theme.cardColor),
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: const [AppShadows.md],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RoundButton(
            icon: Icons.remove_rounded,
            semanticsLabel: context.localizations.lblDecreaseQuantity,
            enabled: canDecrement,
            onTap: onDecrement,
          ),
          SizedBox(
            width: _numberWidth,
            child: AnimatedSwitcher(
              duration: reduceMotion ? Duration.zero : AppMotion.fast,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge?.bold,
              ),
            ),
          ),
          _RoundButton(
            icon: Icons.add_rounded,
            semanticsLabel: context.localizations.lblIncreaseQuantity,
            enabled: canIncrement,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatefulWidget {
  final IconData icon;
  final String semanticsLabel;
  final bool enabled;
  final VoidCallback onTap;

  const _RoundButton({
    required this.icon,
    required this.semanticsLabel,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<_RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<_RoundButton> {
  static const _disabledOpacity = 0.4;
  static const _pressedScale = 0.85;
  static const _iconScale = 0.7;

  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.enabled && _pressed != value) setState(() => _pressed = value);
  }

  void _handleTap() {
    HapticFeedback.selectionClick();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    const size = QuantityStepper._buttonSize;
    final colors = context.theme.colorScheme;

    return Semantics(
      button: true,
      enabled: widget.enabled,
      label: widget.semanticsLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.enabled ? _handleTap : null,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: SizedBox.square(
          dimension: QuantityStepper._tapSize,
          child: Center(
            child: AnimatedScale(
              duration: AppMotion.fast,
              scale: _pressed ? _pressedScale : 1,
              child: AnimatedOpacity(
                duration: AppMotion.fast,
                opacity: widget.enabled ? 1 : _disabledOpacity,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: colors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: colors.onSecondary,
                    size: size * _iconScale,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
