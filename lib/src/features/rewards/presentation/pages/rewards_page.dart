import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/di/di.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/rewards/presentation/presentation.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const String routePath = "/rewards";

  @override
  Widget build(BuildContext context) {
    final bottomInset = context.padding.bottom + AppInsets.md;
    final titles = rewardsTabTitles(context);

    return BlocProvider(
      create: (_) => inject<RewardsCubit>()..load(),
      child: DefaultTabController(
        length: titles.length,
        animationDuration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : AppMotion.fast,
        child: Builder(
          builder: (context) {
            final member = context.select(
              (RewardsCubit cubit) => cubit.state.member,
            );

            return Scaffold(
              appBar: AppBar(
                backgroundColor: context.theme.cardColor,
                centerTitle: false,
                titleSpacing: AppInsets.md,
                title: Text(
                  context.localizations.lblJdonutRewards,
                  style: context.textTheme.headlineLarge,
                ),
                actions: [
                  if (member != null)
                    RewardsBadgeChip(count: member.availableRewards),
                ],
                actionsPadding: EdgeInsets.zero,
              ),
              body: SafeArea(
                bottom: false,
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) => [
                    SliverToBoxAdapter(
                      child: _LadderWithRing(
                        screenWidth: context.width,
                        member: member,
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: RewardsTabChipsHeader(
                        extent: RewardsTabChipsHeader.extentFor(context),
                      ),
                    ),
                  ],
                  body: TabBarView(
                    children: [
                      ChallengesTabView(bottomInset: bottomInset),
                      RewardsComingSoonView(
                        title: titles.last,
                        bottomInset: bottomInset,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LadderWithRing extends StatelessWidget {
  final double screenWidth;
  final Member? member;

  const _LadderWithRing({required this.screenWidth, required this.member});

  static const _ringSizeFactor = 0.52;
  static const _ringOverflowFactor = 0.1;
  static const _skeletonHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    final member = this.member;
    final ringSize = screenWidth * _ringSizeFactor;
    final overflow = ringSize * _ringOverflowFactor;
    const pagePadding = AppInsets.lg;

    return Container(
      color: context.theme.cardColor,
      padding: const EdgeInsets.all(AppInsets.md),
      child: member == null
          ? const SizedBox(
              height: _skeletonHeight,
              child: StyledShimmer(radius: AppRadius.lg),
            )
          : Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: ringSize - overflow - pagePadding + AppInsets.sm,
                  ),
                  child: TierLadder(
                    currentTier: member.tier,
                    progressToNextTier: member.progressToNextTier,
                    pointsToNextTier: member.pointsToNextTier,
                  ),
                ),
                Positioned(
                  right: -(pagePadding + overflow),
                  child: PointsRing(
                    size: ringSize,
                    progress: member.progressToNextTier,
                    totalPoints: member.totalPoints,
                    delay: AppMotion.tierStagger,
                  ),
                ),
              ],
            ),
    );
  }
}
