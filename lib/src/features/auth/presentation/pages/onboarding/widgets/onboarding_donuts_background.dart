import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class OnboardingDonutsBackground extends StatelessWidget {
  final bool animate;

  const OnboardingDonutsBackground({super.key, this.animate = true});

  static const _donutSize = 200.0;
  static const _spacing = 24.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const step = _donutSize + _spacing;
        final columns = (constraints.maxWidth / step).ceil() + 2;
        final rows = (constraints.maxHeight / step).ceil() + 1;

        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          children: [
            for (var row = 0; row < rows; row++)
              for (var column = 0; column < columns; column++)
                Positioned(
                  left: column * step - (row.isOdd ? step / 2 : step),
                  top: row * step,
                  child:
                      _CircularDonut(
                        index: row * columns + column,
                        patternIndex: row * columns + column + row,
                      ).slideUpIn(
                        enabled: animate,
                        delay: AppMotion.stagger * (row + column),
                      ),
                ),
          ],
        );
      },
    );
  }
}

class _CircularDonut extends StatelessWidget {
  final int index;
  final int patternIndex;

  const _CircularDonut({required this.index, required this.patternIndex});

  @override
  Widget build(BuildContext context) {
    const size = OnboardingDonutsBackground._donutSize;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            AuthImages.patterns[patternIndex % AuthImages.patterns.length],
          ),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Image.asset(
        AuthImages.donuts[index % AuthImages.donuts.length],
        fit: BoxFit.contain,
      ),
    );
  }
}
