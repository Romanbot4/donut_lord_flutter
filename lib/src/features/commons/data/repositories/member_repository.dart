import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@LazySingleton(as: IMemberRepository)
class MemberRepository implements IMemberRepository {
  final MemberLocalDataSource _local;

  const MemberRepository(this._local);

  @override
  Stream<Member> watchMember() async* {
    await _local.seedIfEmpty();
    yield* _local.watchMember();
  }
}
