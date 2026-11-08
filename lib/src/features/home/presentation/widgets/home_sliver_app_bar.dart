import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomeSliverAppBar extends StatelessWidget {
  final String memberName;
  final Member? member;
  final List<Shop> shops;
  final bool isLoadingShops;

  const HomeSliverAppBar({
    super.key,
    required this.memberName,
    required this.member,
    required this.shops,
    required this.isLoadingShops,
  });

  static const _bannerWidthFactor = 0.78;
  static const _bottomRadius = 32.0;
  static const _bottomBorderWidth = 2.0;

  MemberTier get tier => member?.tier ?? MemberTier.bronze;

  @override
  Widget build(BuildContext context) {
    final bannerWidth = context.width * _bannerWidthFactor;
    final metrics = _HeaderMetrics(
      context,
      bannerWidth: bannerWidth,
      showShops: isLoadingShops || shops.isNotEmpty,
    );
    const shape = BottomRoundedBorder(
      radius: _bottomRadius,
      side: BorderSide(
        color: AppColors.white,
        width: _bottomBorderWidth,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    );

    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: tier.headerColor,
      shape: shape,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: metrics.toolbarHeight,
      expandedHeight: metrics.toolbarHeight + metrics.shopSectionHeight,
      actionsPadding: EdgeInsets.zero,
      centerTitle: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: AppInsets.md),
        child: _ToolbarContent(header: this, metrics: metrics),
      ),
      flexibleSpace: ClipPath(
        clipper: const ShapeBorderClipper(shape: shape),
        clipBehavior: Clip.antiAlias,
        child: OverflowBox(
          alignment: Alignment.topCenter,
          minHeight: metrics.expandedExtent,
          maxHeight: metrics.expandedExtent,
          child: _TierBackground(
            tier: tier,
            metrics: metrics,
            shops: shops,
            isLoadingShops: isLoadingShops,
            bannerWidth: bannerWidth,
          ),
        ),
      ),
    );
  }
}

class _HeaderMetrics {
  final double topPadding;
  final double profileHeight;
  final double pillHeight;
  final double bannerHeight;
  final bool showShops;

  _HeaderMetrics(
    BuildContext context, {
    required double bannerWidth,
    required this.showShops,
  }) : topPadding = context.padding.top,
       profileHeight = _profileHeight(context),
       pillHeight =
           context.lineHeight(context.textTheme.labelSmall) + 2 * AppInsets.xxs,
       bannerHeight = HomeShopList.heightFor(bannerWidth);

  static const avatarSize = 48.0;
  static const gap = AppSpacing.sm;

  double get toolbarHeight =>
      AppSpacing.xs + profileHeight + AppSpacing.xs + pillHeight + gap;

  double get shopSectionHeight => showShops ? bannerHeight + gap : 0;

  double get expandedExtent => topPadding + toolbarHeight + shopSectionHeight;

  static double _profileHeight(BuildContext context) {
    final textHeight =
        context.lineHeight(context.textTheme.headlineMedium) +
        context.lineHeight(context.textTheme.bodySmall);
    return textHeight > avatarSize ? textHeight : avatarSize;
  }
}

class _TierBackground extends StatelessWidget {
  final MemberTier tier;
  final _HeaderMetrics metrics;
  final List<Shop> shops;
  final bool isLoadingShops;
  final double bannerWidth;

  const _TierBackground({
    required this.tier,
    required this.metrics,
    required this.shops,
    required this.isLoadingShops,
    required this.bannerWidth,
  });

  static const _badgeOverflowFactor = 0.28;
  static const _badgeTopFactor = 0.2;

  @override
  Widget build(BuildContext context) {
    final badgeSize = metrics.topPadding + metrics.toolbarHeight * 2;

    return ColoredBox(
      color: tier.headerColor,
      child: Stack(
        children: [
          Positioned(
            right: -badgeSize * _badgeOverflowFactor,
            top: badgeSize * _badgeTopFactor,
            child: SvgPicture.asset(
              tier.badgeAsset,
              width: badgeSize,
              height: badgeSize,
            ),
          ),
          if (metrics.showShops)
            Positioned(
              left: 0,
              right: 0,
              bottom: _HeaderMetrics.gap,
              height: metrics.bannerHeight,
              child: HomeShopList(
                shops: shops,
                isLoading: isLoadingShops,
                cardWidth: bannerWidth,
              ),
            ),
        ],
      ),
    );
  }
}

class _ToolbarContent extends StatelessWidget {
  final HomeSliverAppBar header;
  final _HeaderMetrics metrics;

  const _ToolbarContent({required this.header, required this.metrics});

  @override
  Widget build(BuildContext context) {
    final member = header.member;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        SizedBox(
          height: metrics.profileHeight,
          child: _ProfileRow(header: header),
        ),
        if (member == null)
          StyledShimmer(
            width: context.width / 2,
            height: metrics.pillHeight,
            radius: AppRadius.full,
          )
        else
          _PointsPill(member: member),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final HomeSliverAppBar header;

  const _ProfileRow({required this.header});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.xs,
      children: [
        _MemberAvatar(name: header.memberName),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(header.memberName, style: context.textTheme.headlineMedium),
              Text(
                context.localizations.lblTierMember(header.tier.label(context)),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
        HomeNotificationBell(
          unreadCount: header.member?.unreadNotifications ?? 0,
        ),
      ],
    );
  }
}

class _PointsPill extends StatelessWidget {
  final Member member;

  const _PointsPill({required this.member});

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final next = member.tier.next;
    final text = next == null
        ? strings.lblTopTierReached
        : strings.lblPointsToNextTier(
            NumberFormat.decimalPattern(strings.localeName)
                .format(member.pointsToNextTier),
            next.label(context),
          );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.sm,
        vertical: AppInsets.xxs,
      ),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  final String name;

  const _MemberAvatar({required this.name});

  static const _ringWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final trimmed = name.trim();
    final colors = context.theme.colorScheme;

    return Container(
      width: _HeaderMetrics.avatarSize,
      height: _HeaderMetrics.avatarSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: context.theme.cardColor, width: _ringWidth),
      ),
      child: Text(
        trimmed.isEmpty ? '?' : trimmed.characters.first.toUpperCase(),
        style: context.textTheme.titleLarge?.copyWith(color: colors.onPrimary),
      ),
    );
  }
}
