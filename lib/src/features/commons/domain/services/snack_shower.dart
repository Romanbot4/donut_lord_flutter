enum SnackGravity { top, bottom }

abstract interface class ISnackShower {
  void info({required String message, SnackGravity gravity = SnackGravity.top});

  void error({
    required String message,
    SnackGravity gravity = SnackGravity.top,
  });

  void success({
    required String message,
    SnackGravity gravity = SnackGravity.top,
  });
}
