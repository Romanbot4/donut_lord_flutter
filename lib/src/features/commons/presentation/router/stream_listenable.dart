import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamListenable extends ChangeNotifier {
  late final StreamSubscription<Object?> _subscription;

  StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
