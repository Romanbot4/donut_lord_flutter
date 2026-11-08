import 'package:jdonuts/src/features/home/domain/domain.dart';

abstract interface class IMemberRepository {
  Stream<Member> watchMember();
}
