import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomeShopList extends StatefulWidget {
  final List<Shop> shops;
  final bool isLoading;
  final double cardWidth;

  const HomeShopList({
    super.key,
    required this.shops,
    required this.isLoading,
    required this.cardWidth,
  });

  static const aspectRatio = 4 / 3;
  static const _skeletonCount = 2;

  static double heightFor(double cardWidth) => cardWidth / aspectRatio;

  @override
  State<HomeShopList> createState() => _HomeShopListState();
}

class _HomeShopListState extends State<HomeShopList> {
  final _controller = ScrollController();
  Timer? _autoPlay;
  bool _isUserScrolling = false;

  double get _step => widget.cardWidth + AppSpacing.sm;

  bool get _canAutoPlay =>
      !widget.isLoading &&
      widget.shops.length > 1 &&
      !MediaQuery.disableAnimationsOf(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _restartAutoPlay();
  }

  @override
  void didUpdateWidget(HomeShopList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading != widget.isLoading ||
        oldWidget.shops.length != widget.shops.length) {
      _restartAutoPlay();
    }
  }

  void _restartAutoPlay() {
    _autoPlay?.cancel();
    if (!_canAutoPlay) return;
    _autoPlay = Timer.periodic(AppMotion.bannerInterval, (_) => _next());
  }

  void _next() {
    if (_isUserScrolling || !_controller.hasClients) return;
    final position = _controller.position;
    final isAtEnd = position.pixels >= position.maxScrollExtent;
    final nextIndex = isAtEnd ? 0 : (position.pixels / _step).round() + 1;
    _controller.animateTo(
      (nextIndex * _step).clamp(0, position.maxScrollExtent),
      duration: AppMotion.medium,
      curve: AppMotion.entranceCurve,
    );
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _isUserScrolling = true;
      _autoPlay?.cancel();
    } else if (notification is ScrollEndNotification && _isUserScrolling) {
      _isUserScrolling = false;
      _restartAutoPlay();
    }
    return false;
  }

  @override
  void dispose() {
    _autoPlay?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.isLoading
        ? HomeShopList._skeletonCount
        : widget.shops.length;
    const backgrounds = HomeImages.shopBackgrounds;

    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: widget.isLoading
            ? const NeverScrollableScrollPhysics()
            : null,
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
        itemCount: count,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) => SizedBox(
          width: widget.cardWidth,
          child: widget.isLoading
              ? const StyledShimmer(radius: AppRadius.lg)
              : HomeShopCard(
                  shop: widget.shops[index],
                  background: backgrounds[index % backgrounds.length],
                ),
        ),
      ),
    );
  }
}
