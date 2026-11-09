import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/rewards/data/data.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

@lazySingleton
class RewardsLocalDataSource {
  final AppDatabase _db;
  final AssetBundle _bundle;

  const RewardsLocalDataSource(this._db, this._bundle);

  static const seedAsset = 'assets/seed/challenges.json';

  Future<void> seedIfEmpty() async {
    final first = await (_db.select(
      _db.challenges,
    )..limit(1)).getSingleOrNull();
    if (first != null) return;

    final seed = jsonDecode(await _bundle.loadString(seedAsset));
    await replaceChallenges(
      ChallengesModel.fromJson(seed as Map<String, dynamic>).challenges,
    );
  }

  Future<void> replaceChallenges(List<ChallengeModel> challenges) {
    return _db.transaction(() async {
      await _db.delete(_db.challenges).go();
      await _db.batch(
        (batch) => batch.insertAll(_db.challenges, [
          for (final (position, challenge) in challenges.indexed)
            ChallengesCompanion.insert(
              id: challenge.id,
              position: position,
              title: challenge.title,
              current: challenge.current,
              target: challenge.target,
              rewardPoints: challenge.rewardPoints,
              progressStyle: Value(challenge.progressStyle),
              imageUrl: challenge.imageUrl,
              imageAspectRatio: challenge.imageAspectRatio,
            ),
        ]),
      );
    });
  }

  Stream<List<Challenge>> watchChallenges() =>
      (_db.select(_db.challenges)
            ..orderBy([(challenge) => OrderingTerm.asc(challenge.position)]))
          .watch()
          .map((rows) => rows.map(_toEntity).toList());

  Challenge _toEntity(ChallengeRow row) => ChallengeModel(
    id: row.id,
    title: row.title,
    current: row.current,
    target: row.target,
    rewardPoints: row.rewardPoints,
    progressStyle: row.progressStyle,
    imageUrl: row.imageUrl,
    imageAspectRatio: row.imageAspectRatio,
  ).toEntity();
}
