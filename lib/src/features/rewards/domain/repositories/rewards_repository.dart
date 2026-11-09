import 'package:jdonuts/src/features/rewards/domain/domain.dart';

abstract interface class IRewardsRepository {
  Stream<List<Challenge>> watchChallenges();

  Future<void> refresh();
}
