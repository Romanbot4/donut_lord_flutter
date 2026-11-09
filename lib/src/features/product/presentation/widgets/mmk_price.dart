import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

String formatMmk(BuildContext context, int amount) =>
    context.localizations.lblPriceMmk(
      NumberFormat.decimalPattern(
        context.localizations.localeName,
      ).format(amount),
    );
