import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomeMenuSection extends StatelessWidget {
  final MenuSection section;
  final VoidCallback onRefresh;

  const HomeMenuSection({
    super.key,
    required this.section,
    required this.onRefresh,
  });

  static const featuredWidthFactor = 0.7;
  static const _compactVisibleCards = 2.4;
  static const _compactMinWidth = 120.0;
  static const _compactMaxWidth = 200.0;

  static double cardWidth(BuildContext context, double cardAspectRatio) {
    if (cardAspectRatio > 1) return context.width * featuredWidthFactor;
    final available = context.width - 2 * AppInsets.md;
    return (available / _compactVisibleCards).clamp(
      _compactMinWidth,
      _compactMaxWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = cardWidth(context, section.itemAspectRatio);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        _SectionTitle(title: section.title),
        if (section.items.isEmpty)
          StyledSectionEmpty(onRefresh: onRefresh)
        else
          SizedBox(
            height: MenuItemCard.heightFor(
              context,
              width,
              section.itemAspectRatio,
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
              itemCount: section.items.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) => MenuItemCard(
                item: section.items[index],
                width: width,
                cardAspectRatio: section.itemAspectRatio,
                heroTag: 'menu-${section.id}-${section.items[index].id}',
              ),
            ),
          ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  static const _chevronIconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final chevronSize = context.textTheme.headlineSmall?.lineHeight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
      child: Row(
        children: [
          Expanded(child: Text(title, style: context.textTheme.headlineSmall)),
          Container(
            width: chevronSize,
            height: chevronSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              shape: BoxShape.circle,
            ),
            child: const StyledSvgIcon(
              AppIcons.chevronRightLinear,
              size: _chevronIconSize,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeMenuSectionSkeleton extends StatelessWidget {
  final double cardAspectRatio;

  const HomeMenuSectionSkeleton({super.key, this.cardAspectRatio = 1});

  static const _placeholderCards = 3;
  static const _titleWidth = 160.0;

  @override
  Widget build(BuildContext context) {
    final width = HomeMenuSection.cardWidth(context, cardAspectRatio);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
          child: StyledShimmer(
            width: _titleWidth,
            height: context.lineHeight(context.textTheme.headlineSmall),
          ),
        ),
        SizedBox(
          height: MenuItemCard.heightFor(context, width, cardAspectRatio),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
            itemCount: _placeholderCards,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (_, _) => MenuItemCardSkeleton(
              width: width,
              cardAspectRatio: cardAspectRatio,
            ),
          ),
        ),
      ],
    );
  }
}
