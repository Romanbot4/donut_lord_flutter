import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledNavigationItem {
  final String label;
  final String icon;
  final String selectedIcon;
  final Color? color;
  final Color selectedColor;

  const StyledNavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.selectedColor,
    this.color,
  });
}

class StyledNavigationBar extends StatelessWidget {
  final List<StyledNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const StyledNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  static const height = 64.0;
  static const _topRadius = 32.0;
  static const _selectedSlotUnits = 2;
  static const _pillBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : AppMotion.medium;

    return Container(
      height: height + context.padding.bottom,
      padding: EdgeInsets.only(
        left: AppInsets.sm,
        right: AppInsets.sm,
        bottom: context.padding.bottom,
      ),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_topRadius),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final unit =
              constraints.maxWidth / (items.length + _selectedSlotUnits - 1);
          double left(int index) =>
              index * unit + (index > currentIndex ? unit : 0);
          double width(int index) =>
              index == currentIndex ? unit * _selectedSlotUnits : unit;

          return Stack(
            children: [
              _pill(
                context,
                left: left(currentIndex),
                width: width(currentIndex),
                duration: duration,
              ),
              for (final (index, item) in items.indexed)
                AnimatedPositioned(
                  duration: duration,
                  curve: AppMotion.entranceCurve,
                  left: left(index),
                  width: width(index),
                  top: 0,
                  bottom: 0,
                  child: _NavigationButton(
                    item: item,
                    isSelected: index == currentIndex,
                    duration: duration,
                    onTap: () => onTap?.call(index),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _pill(
    BuildContext context, {
    required double left,
    required double width,
    required Duration duration,
  }) {
    const inset = AppInsets.xs;

    return AnimatedPositioned(
      duration: duration,
      curve: AppMotion.entranceCurve,
      left: left + inset / 2,
      width: width - inset,
      top: inset,
      bottom: inset,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: context.theme.colorScheme.onPrimary,
            width: _pillBorderWidth,
          ),
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final StyledNavigationItem item;
  final bool isSelected;
  final Duration duration;
  final VoidCallback onTap;

  const _NavigationButton({
    required this.item,
    required this.isSelected,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? item.selectedColor : item.color;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              StyledSvgIcon(
                isSelected ? item.selectedIcon : item.icon,
                color: color,
              ),
              Flexible(
                child: ClipRect(
                  child: AnimatedAlign(
                    duration: duration,
                    curve: AppMotion.entranceCurve,
                    alignment: Alignment.centerLeft,
                    widthFactor: isSelected ? 1 : 0,
                    child: AnimatedOpacity(
                      duration: duration,
                      curve: AppMotion.entranceCurve,
                      opacity: isSelected ? 1 : 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppInsets.xxs),
                        child: Text(
                          item.label,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: color,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
