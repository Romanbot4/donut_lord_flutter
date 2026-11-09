import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

List<String> rewardsTabTitles(BuildContext context) => [
  context.localizations.lblEatMoreEarnMore,
  context.localizations.lblGift,
];

class RewardsTabChipsHeader extends SliverPersistentHeaderDelegate {
  final double extent;

  const RewardsTabChipsHeader({required this.extent});

  static double extentFor(BuildContext context) {
    final label = MediaQuery.textScalerOf(context)
        .scale(context.textTheme.titleMedium!.lineHeight!);
    final chip = label + 2 * AppInsets.xs + 2 * _borderWidth;
    final tabBar = chip > _minTabBarHeight ? chip : _minTabBarHeight;
    return tabBar + AppInsets.xs;
  }

  static const _borderWidth = 2.0;
  static const _minTabBarHeight = 46.0;

  @override
  double get minExtent => extent;

  @override
  double get maxExtent => extent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    return ColoredBox(
      color: context.theme.scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: _TabChips(titles: rewardsTabTitles(context)),
      ),
    );
  }

  @override
  bool shouldRebuild(RewardsTabChipsHeader oldDelegate) => true;
}

class _TabChips extends StatelessWidget {
  final List<String> titles;

  const _TabChips({required this.titles});

  static const _indicatorHorizontalPadding = 4.0;
  static const _indicatorBottomPadding = 2.0;

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    final white = context.theme.cardColor;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ColoredBox(color: white)),
                const Expanded(child: SizedBox.expand()),
              ],
            ),
          ),
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            dividerColor: AppColors.transparent,
            overlayColor: WidgetStateProperty.all(AppColors.transparent),
            indicatorPadding: const EdgeInsets.symmetric(
              horizontal: _indicatorHorizontalPadding,
            ).copyWith(bottom: _indicatorBottomPadding),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: ShapeDecoration(
              color: context.theme.colorScheme.secondary,
              shape: StadiumBorder(side: BorderSide(color: white, width: 0)),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: AppInsets.xxs),
            labelColor: context.theme.colorScheme.onSecondary,
            unselectedLabelColor: context.textTheme.bodyMedium?.color,
            labelStyle: context.textTheme.titleMedium,
            unselectedLabelStyle: context.textTheme.titleMedium,
            tabs: [
              for (final (index, title) in titles.indexed)
                _ChipTab(controller: controller, index: index, title: title),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChipTab extends StatelessWidget {
  final TabController controller;
  final int index;
  final String title;

  const _ChipTab({
    required this.controller,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final animation = controller.animation!;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final active = (1 - (animation.value - index).abs()).clamp(0.0, 1.0);
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppInsets.md,
            vertical: AppInsets.xs,
          ),
          decoration: ShapeDecoration(
            color: context.theme.scaffoldBackgroundColor.withValues(
              alpha: 1 - active,
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: context.theme.cardColor,
                width: RewardsTabChipsHeader._borderWidth,
              ),
            ),
          ),
          child: child,
        );
      },
      child: Text(title),
    );
  }
}

class RewardsComingSoonView extends StatelessWidget {
  final String title;
  final double bottomInset;

  const RewardsComingSoonView({
    super.key,
    required this.title,
    required this.bottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(
        AppInsets.lg,
        AppInsets.xl,
        AppInsets.lg,
        bottomInset,
      ),
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.localizations.lblComingSoon,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
