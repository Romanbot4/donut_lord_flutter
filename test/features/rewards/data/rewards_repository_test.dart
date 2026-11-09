import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/rewards/data/data.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

import '../../../support/seed_bundle.dart';

class _FakeRewardsApiClient implements RewardsApiClient {
  bool failNext = false;

  @override
  Future<ApiEnvelope<ChallengesModel>> getChallenges() async {
    if (failNext) throw Exception('offline');
    return const ApiEnvelope(
      data: ChallengesModel(
        challenges: [
          ChallengeModel(
            id: 'americano',
            title: 'Drink 12 cups americano',
            current: 9,
            target: 12,
            rewardPoints: 100,
            progressStyle: 'arc',
            imageUrl: 'https://cdn.test/coffee.png',
          ),
        ],
      ),
    );
  }
}

void main() {
  late AppDatabase db;
  late _FakeRewardsApiClient api;
  late RewardsRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    api = _FakeRewardsApiClient();
    repository = RewardsRepository(
      RewardsLocalDataSource(db, SeedBundle()),
      api,
    );
  });

  tearDown(() => db.close());

  test('seeds the bundled challenges on first watch', () async {
    final challenges = await repository.watchChallenges().first;

    expect(challenges.single.title, 'Eat 4 Coco donuts');
    expect(challenges.single.progressStyle, ChallengeProgressStyle.donut);
    expect(challenges.single.isComplete, isTrue);
  });

  test('refreshing replaces the cached challenges', () async {
    await repository.watchChallenges().first;

    await repository.refresh();
    final challenges = await repository.watchChallenges().first;

    expect(challenges.single.id, 'americano');
    expect(challenges.single.progress, 0.75);
  });

  test('a failed refresh keeps the cached challenges', () async {
    await repository.watchChallenges().first;
    api.failNext = true;

    await expectLater(repository.refresh(), throwsException);
    final challenges = await repository.watchChallenges().first;

    expect(challenges.single.id, 'coco-donuts');
  });
}
