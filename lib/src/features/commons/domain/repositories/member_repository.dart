import 'package:jdonuts/src/features/commons/domain/domain.dart';

abstract interface class IMemberRepository {
  Stream<Member> watchMember();
}
