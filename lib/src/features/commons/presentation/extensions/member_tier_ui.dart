import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

extension MemberTierUi on MemberTier {
  Color get headerColor => switch (this) {
    MemberTier.bronze => AppColors.bronzeHeader,
    MemberTier.silver => AppColors.silverHeader,
    MemberTier.gold => AppColors.goldHeader,
  };

  String get badgeAsset => switch (this) {
    MemberTier.bronze => AppImages.bronzeBadge,
    MemberTier.silver => AppImages.silverBadge,
    MemberTier.gold => AppImages.goldBadge,
  };

  String label(BuildContext context) => switch (this) {
    MemberTier.bronze => context.localizations.lblTierBronze,
    MemberTier.silver => context.localizations.lblTierSilver,
    MemberTier.gold => context.localizations.lblTierGold,
  };
}
