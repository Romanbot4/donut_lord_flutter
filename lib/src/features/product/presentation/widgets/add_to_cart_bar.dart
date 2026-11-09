import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/product/presentation/presentation.dart';

class AddToCartBar extends StatelessWidget {
  final int? totalMmk;
  final VoidCallback onTap;

  const AddToCartBar({super.key, required this.totalMmk, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final total = totalMmk;
    final addToCart = context.localizations.btnAddToCart;
    final label = total == null
        ? addToCart
        : '$addToCart  |  ${formatMmk(context, total)}';

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppInsets.md,
          AppInsets.xs,
          AppInsets.md,
          AppInsets.sm,
        ),
        child: StyledPrimaryButton(
          label: label,
          isEnabled: total != null,
          onTap: total == null ? null : onTap,
        ),
      ),
    );
  }
}
