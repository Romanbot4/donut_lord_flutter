import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/features/cart/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class CartFloatingBar extends StatefulWidget {
  final VoidCallback onCheckout;

  const CartFloatingBar({super.key, required this.onCheckout});

  static const height = 48.0;

  @override
  State<CartFloatingBar> createState() => _CartFloatingBarState();
}

class _CartFloatingBarState extends State<CartFloatingBar>
    with SingleTickerProviderStateMixin {
  static const _hiddenOffset = Offset(0, 1.5);
  static const _afterRouteExit = AppMotion.fast;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.medium,
    value: context.read<CartCubit>().state.itemCount > 0 ? 1 : 0,
  );

  late final Animation<Offset> _slide = Tween(
    begin: _hiddenOffset,
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInCubic,
    ),
  );

  bool get _reduceMotion => MediaQuery.disableAnimationsOf(context);

  void _onCartChanged(CartState previous, CartState current) {
    if (current.itemCount == 0) {
      _reduceMotion ? _controller.value = 0 : _controller.reverse();
      return;
    }
    if (current.itemCount <= previous.itemCount) return;
    if (_reduceMotion) {
      _controller.value = 1;
      return;
    }
    Future.delayed(_afterRouteExit, () {
      if (mounted) _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = context.select((CartCubit cart) => cart.state.itemCount);
    CartState? previous;

    return BlocListener<CartCubit, CartState>(
      listenWhen: (before, after) {
        previous = before;
        return before.itemCount != after.itemCount;
      },
      listener: (_, current) => _onCartChanged(previous!, current),
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _controller,
          child: IgnorePointer(
            ignoring: itemCount == 0,
            child: _Pill(itemCount: itemCount, onTap: widget.onCheckout),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final int itemCount;
  final VoidCallback onTap;

  const _Pill({required this.itemCount, required this.onTap});

  static const _borderWidth = 2.0;
  static const _dividerWidth = 1.0;
  static const _dividerHeight = 24.0;
  static const _dividerOpacity = 0.6;

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final onColor = context.theme.colorScheme.onPrimary;
    final textStyle = context.textTheme.titleSmall?.copyWith(color: onColor);

    return Semantics(
      button: true,
      label: '${strings.lblCartItems(itemCount)}, ${strings.btnCheckOut}',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: CartFloatingBar.height,
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: onColor, width: _borderWidth),
            boxShadow: const [AppShadows.lg],
          ),
          child: Row(
            spacing: AppSpacing.xs,
            children: [
              StyledSvgIcon(AppIcons.bagLinear, color: onColor),
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppMotion.fast,
                  child: Text(
                    strings.lblCartItems(itemCount),
                    key: ValueKey(itemCount),
                    maxLines: 1,
                    style: textStyle,
                  ),
                ),
              ),
              Container(
                width: _dividerWidth,
                height: _dividerHeight,
                color: onColor.withValues(alpha: _dividerOpacity),
              ),
              Text(strings.btnCheckOut, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
