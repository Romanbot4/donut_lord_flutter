enum MemberTier {
  bronze,
  silver,
  gold;

  MemberTier? get next {
    final nextIndex = index + 1;
    return nextIndex < values.length ? values[nextIndex] : null;
  }
}

class Member {
  final MemberTier tier;
  final int totalPoints;
  final int pointsToNextTier;
  final double progressToNextTier;
  final int unreadNotifications;
  final int availableRewards;

  const Member({
    required this.tier,
    required this.totalPoints,
    required this.pointsToNextTier,
    required this.progressToNextTier,
    required this.unreadNotifications,
    required this.availableRewards,
  });
}
