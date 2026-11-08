import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@LazySingleton(as: ISessionEvents)
class SessionEvents implements ISessionEvents {
  final _expired = StreamController<void>.broadcast();

  @override
  Stream<void> get onExpired => _expired.stream;

  @override
  void expire() => _expired.add(null);
}
