import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/di/di.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routePath = "/";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inject<HomeCubit>()..start(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  static const _skeletonAspectRatios = [4 / 3, 3 / 4, 1.0];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final state = context.watch<HomeCubit>().state;
    final memberName = context.select(
      (SessionCubit session) => switch (session.state) {
        SessionAuthenticated(:final user) => user.name,
        _ => '',
      },
    );
    final animate = !MediaQuery.disableAnimationsOf(context);
    final sections = _sections(state, cubit);

    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current.refreshFailure != null &&
          previous.refreshFailure != current.refreshFailure,
      listener: (context, _) => Snacks.error(
        context,
        message: context.localizations.lblRefreshFailed,
      ),
      child: ColoredBox(
        color: context.theme.scaffoldBackgroundColor,
        child: RefreshIndicator(
          onRefresh: cubit.refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              HomeSliverAppBar(
                memberName: memberName,
                member: state.member,
                shops: state.feed?.shops ?? const [],
                isLoadingShops: state.isLoading,
              ),
              SliverToBoxAdapter(
                child: StyledOfflineBanner(isOffline: state.isOffline),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: AppInsets.md),
                sliver: SliverList.separated(
                  itemCount: sections.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) => sections[index].slideUpIn(
                        enabled: animate,
                        delay: AppMotion.stagger * index,
                        offset: AppMotion.contentSlideOffset,
                      ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: AppInsets.lg),
                sliver: SliverToBoxAdapter(
                  child: HomeNearbyShopsSection(
                    shops: state.feed?.shops,
                    hasFailed: state.loadFailure != null,
                    onRetry: cubit.retry,
                    bottomInset: IndexLayout.bottomInset(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _sections(HomeState state, HomeCubit cubit) {
    final feed = state.feed;
    if (state.loadFailure != null) {
      return [StyledSectionError(onRetry: cubit.retry)];
    }
    if (feed == null) {
      return [
        for (final ratio in _skeletonAspectRatios)
          HomeMenuSectionSkeleton(cardAspectRatio: ratio),
      ];
    }
    if (feed.menuSections.isEmpty) {
      return [StyledSectionEmpty(onRefresh: cubit.refresh)];
    }
    return [
      for (final section in feed.menuSections)
        HomeMenuSection(section: section, onRefresh: cubit.refresh),
    ];
  }
}
