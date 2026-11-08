import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const String routePath = "/welcome";

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      body: ColoredBox(
        color: context.theme.scaffoldBackgroundColor,
        child: Stack(
          children: [
            Positioned.fill(child: _WelcomeDonutTiles(animate: animate)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _WelcomeSection(animate: animate),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeDonutTiles extends StatelessWidget {
  final bool animate;

  const _WelcomeDonutTiles({required this.animate});

  static const _tileWidthFactor = 0.58;
  static const _leftColumnFactor = -0.14;
  static const _rightColumnFactor = 0.56;
  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tile = constraints.maxWidth * _tileWidthFactor;
        final step = tile + AppSpacing.sm;
        final rows = (constraints.maxHeight / step).ceil();

        return Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            for (var row = 0; row < rows; row++)
              for (var column = 0; column < _columns; column++)
                Positioned(
                  left:
                      constraints.maxWidth *
                      (column == 0 ? _leftColumnFactor : _rightColumnFactor),
                  top: row * step + (column == 1 ? step / 2 : 0) - step / 4,
                  child:
                      _DonutTile(
                        size: tile,
                        index: row * _columns + column,
                        patternIndex: row * _columns + column + row,
                      ).slideUpIn(
                        enabled: animate,
                        delay: AppMotion.stagger * (row * _columns + column),
                      ),
                ),
          ],
        );
      },
    );
  }
}

class _DonutTile extends StatelessWidget {
  final double size;
  final int index;
  final int patternIndex;

  const _DonutTile({
    required this.size,
    required this.index,
    required this.patternIndex,
  });

  static const _donutScale = 0.8;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        image: DecorationImage(
          image: AssetImage(
            AuthImages.patterns[patternIndex % AuthImages.patterns.length],
          ),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Image.asset(
        AuthImages.donuts[index % AuthImages.donuts.length],
        width: size * _donutScale,
        height: size * _donutScale,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  final bool animate;

  const _WelcomeSection({required this.animate});

  static const _fadeHeight = 144.0;

  @override
  Widget build(BuildContext context) {
    final background = context.theme.scaffoldBackgroundColor;
    final strings = context.localizations;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        Text(
          strings.lblWelcomeToTheWorldOfJDonuts,
          style: context.textTheme.displayLarge,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
        StyledPrimaryButton(
          label: strings.btnLetsExplore,
          onTap: () => context.go('/'),
        ),
      ],
    );

    return Column(
      children: [
        Container(
          height: _fadeHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [background.withValues(alpha: 0), background],
            ),
          ),
        ),
        Container(
          color: background,
          padding: const EdgeInsets.all(AppInsets.md),
          child: SafeArea(
            top: false,
            // Fades the title and button up after the tiles have landed.
            child: content.slideUpIn(
              enabled: animate,
              delay: AppMotion.medium,
              offset: AppMotion.contentSlideOffset,
            ),
          ),
        ),
      ],
    );
  }
}
