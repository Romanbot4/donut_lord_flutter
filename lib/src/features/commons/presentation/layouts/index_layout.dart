import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class IndexLayout extends StatelessWidget {
  final Widget child;
  final ValueListenable<int> indexListener;
  final ValueChanged<int>? onTap;
  final bool showBottomNavigationBar;

  const IndexLayout({
    super.key,
    required this.child,
    required this.indexListener,
    this.onTap,
    this.showBottomNavigationBar = false,
  });

  static double bottomInset(BuildContext context) =>
      StyledNavigationBar.height + context.padding.bottom;

  List<StyledNavigationItem> _items(BuildContext context) {
    final strings = context.localizations;
    final color = context.theme.colorScheme.onSecondary;
    final selectedColor = context.theme.colorScheme.onPrimary;

    StyledNavigationItem item(String icon, String label) =>
        StyledNavigationItem(
          icon: icon,
          selectedIcon: icon,
          label: label,
          color: color,
          selectedColor: selectedColor,
        );

    return [
      item(AppIcons.homeLinear, strings.lblHome),
      item(AppIcons.crownLinear, strings.lblReward),
      item(AppIcons.donutLinear, strings.lblOrder),
      item(AppIcons.walletLinear, strings.lblWallet),
      item(AppIcons.settingLinear, strings.lblSettings),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AnimatedContainer(
        duration: AppMotion.fast,
        curve: AppMotion.entranceCurve,
        height: showBottomNavigationBar ? bottomInset(context) : 0,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ValueListenableBuilder<int>(
            valueListenable: indexListener,
            builder: (context, currentIndex, _) => StyledNavigationBar(
              items: _items(context),
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
