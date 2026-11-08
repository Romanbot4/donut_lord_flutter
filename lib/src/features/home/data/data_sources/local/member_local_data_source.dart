import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

@lazySingleton
class MemberLocalDataSource {
  final AppDatabase _db;
  final AssetBundle _bundle;

  const MemberLocalDataSource(this._db, this._bundle);

  static const seedAsset = 'assets/seed/member.json';

  Future<void> seedIfEmpty() async {
    final existing = await (_db.select(_db.members)..limit(1)).getSingleOrNull();
    if (existing != null) return;

    final seed = jsonDecode(await _bundle.loadString(seedAsset));
    final member = MemberModel.fromJson(seed as Map<String, dynamic>);
    await _db.into(_db.members).insert(
      MembersCompanion.insert(
        id: member.id,
        tier: member.tier,
        totalPoints: member.totalPoints,
        pointsToNextTier: member.pointsToNextTier,
        progressToNextTier: member.progressToNextTier,
        unreadNotifications: member.unreadNotifications,
        availableRewards: member.availableRewards,
      ),
    );
  }

  Stream<Member> watchMember() => _db.select(_db.members).watchSingle().map(
    (row) => MemberModel(
      id: row.id,
      tier: row.tier,
      totalPoints: row.totalPoints,
      pointsToNextTier: row.pointsToNextTier,
      progressToNextTier: row.progressToNextTier,
      unreadNotifications: row.unreadNotifications,
      availableRewards: row.availableRewards,
    ).toEntity(),
  );
}
