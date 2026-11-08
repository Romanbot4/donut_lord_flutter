import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

extension MemberTierUi on MemberTier {
  Color get headerColor => switch (this) {
    MemberTier.bronze => AppColors.bronzeHeader,
    MemberTier.silver => AppColors.silverHeader,
    MemberTier.gold => AppColors.goldHeader,
  };

  String get badgeAsset => switch (this) {
    MemberTier.bronze => HomeImages.bronzeBadge,
    MemberTier.silver => HomeImages.silverBadge,
    MemberTier.gold => HomeImages.goldBadge,
  };

  String label(BuildContext context) => switch (this) {
    MemberTier.bronze => context.localizations.lblTierBronze,
    MemberTier.silver => context.localizations.lblTierSilver,
    MemberTier.gold => context.localizations.lblTierGold,
  };
}
