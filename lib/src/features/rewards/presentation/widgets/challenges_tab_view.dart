import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';
import 'package:jdonuts/src/features/rewards/presentation/presentation.dart';

class ChallengesTabView extends StatelessWidget {
  final double bottomInset;

  const ChallengesTabView({super.key, required this.bottomInset});

  static const _skeletonCount = 3;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RewardsCubit>().state;
    final cubit = context.read<RewardsCubit>();
    final challenges = state.challenges;
    final padding = EdgeInsets.fromLTRB(
      AppInsets.md,
      AppInsets.md,
      AppInsets.md,
      bottomInset,
    );

    if (state.isLoadingChallenges) {
      return ListView.separated(
        padding: padding,
        itemCount: _skeletonCount,
        separatorBuilder: _gap,
        itemBuilder: (_, _) => const ChallengeCardSkeleton(),
      );
    }
    if (challenges == null) {
      return ListView(
        padding: padding,
        children: [StyledSectionError(onRetry: cubit.load)],
      );
    }
    if (challenges.isEmpty) {
      return ListView(
        padding: padding,
        children: [StyledSectionEmpty(onRefresh: cubit.load)],
      );
    }
    return _ChallengeList(challenges: challenges, padding: padding);
  }

  static Widget _gap(BuildContext context, int _) =>
      const SizedBox(height: AppSpacing.md);
}

class _ChallengeList extends StatelessWidget {
  final List<Challenge> challenges;
  final EdgeInsets padding;

  const _ChallengeList({required this.challenges, required this.padding});

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);

    return ListView.separated(
      padding: padding,
      itemCount: challenges.length,
      separatorBuilder: ChallengesTabView._gap,
      itemBuilder: (context, index) {
        final entryDelay = AppMotion.stagger * index;
        return ChallengeCard(
          challenge: challenges[index],
          artworkDelay: entryDelay + AppMotion.medium,
        ).slideUpIn(
          enabled: animate,
          delay: entryDelay,
          offset: AppMotion.contentSlideOffset,
        );
      },
    );
  }
}
