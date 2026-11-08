import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

@injectable
class WatchMemberUseCase {
  final IMemberRepository _repository;
  const WatchMemberUseCase(this._repository);

  Stream<Member> call() => _repository.watchMember();
}
